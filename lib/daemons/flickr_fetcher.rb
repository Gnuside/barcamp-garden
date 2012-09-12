#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
require File.join(root, "config", "boot")
require File.join(root, "config", "environment")
require 'pp'

$running = true
Signal.trap("TERM") do 
	$running = false
end

CONFIG_PATH = Rails.root.join( 'config', 'omniauth.yml')
CONFIG = YAML.load_file( CONFIG_PATH )

# setup daemon
FlickRaw.api_key = CONFIG[:flickr][:api_key]
FlickRaw.shared_secret = CONFIG[:flickr][:shared_secret]

while($running) do
	begin

		now = Time.now
		yesterday = Time.now - (60 * 60 * 24)
		tomorrow = Time.now + (60 * 60 * 24)

		Rails.logger.auto_flushing = true
		Rails.logger.info "This daemon is still running at #{Time.now}.\n"

		events = Event.where(
			"dtstart < ? AND dtend > ?", 
			tomorrow.utc, yesterday.utc)

			events.each do |event|
				Rails.logger.info "Fetching for event #{event.inspect}"

				workshops = Workshop.where("event_id = ?", event.id)
				tags = workshops.map{ |w| w.slug }.push(event.slug)

				Rails.logger.debug "Maching tags : #{tags.inspect}"

				# first is newest, last is oldest
				results = flickr.photos.search(:tags => tags.join(','))
				results.each do |picture|
					# info = flickr.photos.getInfo(:photo_id => result.id)  
					# url = FlickRaw.url_b(info)  
					url = FlickRaw.url_b picture

					media = RemoteMedia.where(:platform => 'flickr', :remote_id => picture.id).first
					if media.nil? then
						media = RemoteMedia.new
						media.platform = 'flickr'
						media.description = picture.title
						media.url = url
						media.author = picture.owner
						media.remote_id = picture.id
						media.event_id = event.id
						res = media.save
						Rails.logger.info "Saving media #{picture.inspect} ? #{res}"
					end
				end
			end

	rescue Exception => e
		# FIXME: log & handle properly 
	end

	sleep 60
end
