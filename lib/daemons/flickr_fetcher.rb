#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
	$running = false
end

CONFIG_PATH = File.join( 'config', 'omniauth.yml')
CONFIG = YAML.load_file( CONFIG_PATH )

while($running) do

	# Replace this with your code
	Rails.logger.auto_flushing = true
	Rails.logger.info "This daemon is still running at #{Time.now}.\n"

	FlickRaw.api_key = CONFIG[:flickr][:api_key]
	FlickRaw.shared_secret = CONFIG[:flickr][:shared_secret]

	results = flickr.photos.search(:tags => ARGV[0])  
	rand = Random.new.rand(results.length)  
	info = flickr.photos.getInfo(:photo_id => results[rand].id)  
	pp info
	url = FlickRaw.url_b(info)  
	sleep 10
end
