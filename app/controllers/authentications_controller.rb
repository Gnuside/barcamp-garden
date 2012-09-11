class AuthenticationsController < ApplicationController
	# GET /authentications
	# GET /authentications.json
=begin
  def index
	@authentications = Authentication.all

	respond_to do |format|
	  format.html # index.html.erb
	  format.json { render json: @authentications }
	end
  end
=end
	def index
		@authentications = current_user.authentications if current_user  
	end

	# GET /authentications/1
	# GET /authentications/1.json
=begin
  def show
	@authentication = Authentication.find(params[:id])

	respond_to do |format|
	  format.html # show.html.erb
	  format.json { render json: @authentication }
	end
  end
=end

	# GET /authentications/new
	# GET /authentications/new.json
=begin
  def new
	@authentication = Authentication.new

	respond_to do |format|
	  format.html # new.html.erb
	  format.json { render json: @authentication }
	end
  end
=end

	# GET /authentications/1/edit
=begin
  def edit
	@authentication = Authentication.find(params[:id])
  end
=end

	# POST /authentications
	# POST /authentications.json
=begin
  def create
	@authentication = Authentication.new(params[:authentication])

	respond_to do |format|
	  if @authentication.save
		format.html { redirect_to @authentication, notice: 'Authentication was successfully created.' }
		format.json { render json: @authentication, status: :created, location: @authentication }
	  else
		format.html { render action: "new" }
		format.json { render json: @authentication.errors, status: :unprocessable_entity }
	  end
	end
  end
=end
	def create
		pp request.env["omniauth.auth"].to_yaml  
		omniauth = request.env["omniauth.auth"]  
		authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
		if authentication  
			flash[:notice] = "Signed in successfully."  
			sign_in_and_redirect(:user, authentication.user)  
		elsif current_user  
			current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])  
			flash[:notice] = "Authentication successful."  
			redirect_to authentications_url  
		else  
			user = User.new  
			user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])  
			user.save(:validate => false)
			flash[:notice] = "Signed in successfully."  
			sign_in_and_redirect(:user, user)  
		end  
	end

	# PUT /authentications/1
	# PUT /authentications/1.json
=begin
  def update
	@authentication = Authentication.find(params[:id])

	respond_to do |format|
	  if @authentication.update_attributes(params[:authentication])
		format.html { redirect_to @authentication, notice: 'Authentication was successfully updated.' }
		format.json { head :no_content }
	  else
		format.html { render action: "edit" }
		format.json { render json: @authentication.errors, status: :unprocessable_entity }
	  end
	end
  end
=end

	# DELETE /authentications/1
	# DELETE /authentications/1.json
=begin
  def destroy
	@authentication = Authentication.find(params[:id])
	@authentication.destroy

	respond_to do |format|
	  format.html { redirect_to authentications_url }
	  format.json { head :no_content }
	end
  end
=end
	def destroy
		@authentication = current_user.authentications.find(params[:id])  
		@authentication.destroy  
		flash[:notice] = "Successfully destroyed authentication."  
		redirect_to authentications_url  
	end
end
