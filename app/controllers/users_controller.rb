
class UsersController < ApplicationController
	# FIXME: fix signin/signup forms
	before_filter :authenticate_user!, :except => [:show]
	
	# GET /users
	# GET /users.json
	def index
		@users = User.all
	end


	# GET /users/1
	# GET /users/1.json
	def show
		@user = User.find(params[:id])
	end

	# GET /users/new
	# GET /users/new.json
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
	end

	# POST /users
	# POST /users.json
	def create
		if params[:user][:nopassword] then
			random_string =	(0...8).map{65.+(rand(25)).chr}.join
			params[:user][:password] = random_string
			params[:user][:password_confirmation] = random_string
			params[:user].delete(:nopassword)
		end
		@user = User.new(params[:user])

		if @user.save
			redirect_to @user, notice: 'User was successfully created.'
		else
			render action: "new"
		end
	end

	# PUT /users/1
	# PUT /users/1.json
	def update
		@user = User.find(params[:id])

		if params[:user][:password].blank? 
			params[:user].delete(:password) 
			params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank? 
		end 
		params[:user].delete(:current_password) 
		STDERR.puts params.inspect

		if @user.update_attributes(params[:user])
			redirect_to @user, notice: 'User was successfully updated.'
		else
			render action: "edit"
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to users_url
	end
end
