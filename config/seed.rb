
oldadmin = User.where(:email => "admin@example.com").first

unless oldadmin.nil? then
	STDERR.puts "Initial admin already exists. Skipping..."
	pp oldadmin
	next
end

admin = User.create(
	#:login => "admin",
	#:name => "My Admin",
	:email => "admin@example.com",
	:password => "admin",
	:password_confirmation => "admin"
)
#admin.activated_at = 5.days.ago
#admin.activation_code = nil
admin.admin = true
admin.save :validate => false
STDERR.puts "Admin user created sucessfully. Credentials: admin@example.com / admin"
