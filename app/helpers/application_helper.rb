module ApplicationHelper
	def avatar_url user, size = :small
		default_url = "#{root_url}images/guest.png"
		if user.avatar.exists? then
			user.avatar.url(size)
		else
			geom = case size
				   when :small then "48x48"
				   when :thumb then "100x100"
				   when :medium then "300x300"
				   when :big then "600x600"
				   else "100x100" # thumb by default
				   end
			gravatar_id = Digest::MD5::hexdigest(user.email).downcase
			return "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{geom}"
		end
	end
end
