OMNIAUTH_CONFIG = YAML.load_file(
	Rails.root.join( 'config', 'omniauth.yml')
)

require 'pp'
pp OMNIAUTH_CONFIG

Rails.application.config.middleware.use OmniAuth::Builder do  
	provider :twitter, OMNIAUTH_CONFIG[:twitter][:consumer_key], OMNIAUTH_CONFIG[:twitter][:consumer_secret]
	provider :facebook, OMNIAUTH_CONFIG[:facebook][:app_id], OMNIAUTH_CONFIG[:facebook][:app_secret]
	#provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  
