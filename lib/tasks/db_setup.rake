require 'bundler/setup'
require 'pp'

namespace :db do
	namespace :setup do

		desc "create all default content"
		task :all => [:admin, :event]


		desc "create default event"
		task :event => :environment do
			event = Event.create()
			event.save :validate => false
		end

		desc "create default admin user"
		task :admin => :environment do
			oldadmin = User.where(:email => "admin@example.com").first

			unless oldadmin.nil? then
				STDERR.puts "Initial admin already exists. Skipping..."
				pp oldadmin
				next
			end

			admin = User.create(
				:login => "admin",
				:firstname => "Super",
				:lastname => "Admin",
				:email => "admin@example.com",
				:password => "admin",
				:password_confirmation => "admin"
			)
			#admin.activated_at = 5.days.ago
			#admin.activation_code = nil
			admin.admin = true
			admin.save :validate => false
			STDERR.puts "Admin user created sucessfully. Credentials: admin@example.com / admin"
		end

		desc "Create user accounts with rake, prompting for user name and password."
		task :user => :environment do
			ui = HighLine.new
			name     = ui.ask("Full Human name: ")
			email    = ui.ask("Email: ")
			login    = ui.ask("Login name: ")
			password = ui.ask("Enter password: ") { |q| q.echo = false }
			confirm  = ui.ask("Confirm password: ") { |q| q.echo = false }

			user = User.new(:name => name, :email => email, :login => login, :password => password, :password_confirmation => confirm)
			if user.save :validate => false
				puts "User account '#{login}' created."
			else
				puts
				puts "Problem creating user account:"
				puts user.errors.full_messages
			end
		end

	end
end
