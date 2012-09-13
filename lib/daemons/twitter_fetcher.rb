#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
require File.join(root, "config", "boot")
require File.join(root, "config", "environment")
require 'twitter'
require 'pp'

$running = true
Signal.trap("TERM") do 
	$running = false
end

CONFIG_PATH = Rails.root.join( 'config', 'omniauth.yml')
CONFIG = YAML.load_file( CONFIG_PATH )

# setup daemon

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

				event_tags =  event.slug.split(/[, \t]/)

				Rails.logger.info "Fetching for event #{event.inspect}"

				workshops = Workshop.where("event_id = ?", event.id)
				#pp "WORKSHOPS", workshops

				tags = workshops.map{ |w| w.slug.split(/[, \t]/) }
				tags.concat(event_tags)
				STDERR.puts tags.inspect

				Rails.logger.info "Maching tags : #{tags.inspect}"

				# first is newest, last is oldest
				tags_expr = tags.join(' OR ')

				results = Twitter.search(tags_expr)
				#pp results

				results.each do |tweet|
					STDERR.puts tweet.inspect

					media = RemoteMedium.where(:platform => 'twitter', :remote_id => tweet.id).first
					STDERR.puts media.inspect
					if media.nil? then
						media = RemoteMedium.new
						media.platform = 'twitter'
						media.description = tweet.text
						media.url = tweet.profile_image_url
						media.author = tweet.from_user
						media.remote_id = tweet.id_str
						# keep
						media.event_id = event.id
						res = media.save
						Rails.logger.info "Saving media #{tweet.inspect} ? #{res}"
						STDERR.puts "Saving media #{tweet.inspect} ? #{res}"
					end
				end
			end

	rescue Exception => e
		Rails.logger.error e
		# FIXME: log & handle properly 
	end

	sleep 60
end
