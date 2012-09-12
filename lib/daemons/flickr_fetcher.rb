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

				pp "TAGS", tags

				# first is newest, last is oldest
				results = flickr.photos.search(:tags => event.slug)
				results.each do |picture|
					#info = flickr.photos.getInfo(:photo_id => result.id)  
					url = FlickRaw.url_b picture
					pp picture
					pp url

					media = RemoteMedia.new
					media.platform = 'flickr'
					#media.remote_id
				end
				#url = FlickRaw.url_b(info)  
			end

	rescue Exception => e
		# FIXME: log & handle properly 
	end

	sleep 60
end
