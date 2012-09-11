#!/usr/bin/env ruby

require 'bundler/setup'

require 'etherpad-lite'

APIKEY = File.read("/usr/share/etherpad-lite/APIKEY.txt")

#APIKEY="cKFNXvEqW04fxOpbwguNYXs03CwdAaa9"

# Connect to your Etherpad Lite instance
ether = EtherpadLite.connect('http://localhost:9001', APIKEY)

# Get a Pad (or create one if it doesn't exist)
pad = ether.pad('demo_pad')

puts pad.text
#=> "Welcome to Etherpad Lite!\n\nThis pad text is synchronized as you type, so that everyone viewing..."

# Write your the changes to the Pad
pad.text += "Connected once !"

# There are now 2 revisions!
puts pad.revision_numbers

# Iterate through each revision
pad.revisions.each do |pad_rev|
  puts "Revision #{pad_rev.rev}:"
  puts pad_rev.text
end

