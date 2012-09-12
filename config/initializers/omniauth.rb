
OMNIAUTH_CONFIG_PATH = Rails.root.join( 'config', 'omniauth.yml')

if not File.exist? OMNIAUTH_CONFIG_PATH then
	STDERR.puts "ERROR: #{OMNIAUTH_CONFIG_PATH} is missing. ",
		"Please set up omniauth configuration, refering to #{OMNIAUTH_CONFIG_PATH}.example"
	exit 1
end

OMNIAUTH_CONFIG = YAML.load_file( OMNIAUTH_CONFIG_PATH )

# FIXME: validate presence of fields and load providers accordingly.

=begin
require 'pp'
pp OMNIAUTH_CONFIG
=end

Rails.application.config.middleware.use OmniAuth::Builder do  
	provider :twitter, OMNIAUTH_CONFIG[:twitter][:consumer_key], OMNIAUTH_CONFIG[:twitter][:consumer_secret]
	provider :facebook, OMNIAUTH_CONFIG[:facebook][:app_id], OMNIAUTH_CONFIG[:facebook][:app_secret]
	#provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  
