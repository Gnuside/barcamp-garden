module WorkshopsHelper
	def event_workshop_pad_url event, workshop
		File.join(ETHERPAD_URL,'p',"#{event.slug}_#{workshop.slug}")
	end
end
