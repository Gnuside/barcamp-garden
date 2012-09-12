#!/usr/bin/env ruby

require 'bundler/setup'
require 'flickraw'
require 'launchy'
require 'pp'

CONFIG_PATH = File.join( 'config', 'omniauth.yml')
CONFIG = YAML.load_file( CONFIG_PATH )

FlickRaw.api_key = CONFIG[:flickr][:api_key]
FlickRaw.shared_secret = CONFIG[:flickr][:shared_secret]

results = flickr.photos.search(:tags => ARGV[0])  
rand = Random.new.rand(results.length)  
info = flickr.photos.getInfo(:photo_id => results[rand].id)  
pp info
url = FlickRaw.url_b(info)  
Launchy.open(url)  
