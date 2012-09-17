class UsersController < ApplicationController
	# FIXME: fix signin/signup forms
	before_filter :authenticate_user!	
	
	def index
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
