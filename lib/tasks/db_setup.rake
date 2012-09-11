require 'bundler/setup'

namespace :db do
  namespace :setup do
    desc "create default admin user"
    task :admin => :environment do
      admin = User.create(
        #:login => "admin", 
        #:name => "My Admin", 
        :email => "admin@example.com", 
        :password => "admin", 
        :password_confirmation => "admin"
        )
      admin.activated_at = 5.days.ago
      admin.activation_code = nil
      admin.save false
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
      if user.save false
        puts "User account '#{login}' created."
      else
        puts
        puts "Problem creating user account:"
        puts user.errors.full_messages
      end
    end

  end
end
