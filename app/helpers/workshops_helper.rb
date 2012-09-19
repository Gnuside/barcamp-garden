module WorkshopsHelper
	def event_workshop_pad_name event, workshop
		"#{event.slug}_#{workshop.slug}"
	end

	def event_workshop_pad_url event, workshop
		username = if current_user then
					   current_user.email
				   else 'anonymous'
				   end
		File.join(ETHERPAD_URL,'p',
				  event_workshop_pad_name(event,workshop) + 
				 "?showControls=false&useMonospaceFont=true&userName=#{username}")
	end
end
