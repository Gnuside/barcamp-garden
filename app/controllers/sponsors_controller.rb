class SponsorsController < ApplicationController
	# GET /sponsors
	# GET /sponsors.json
	def index
		@event = Event.find(params[:event_id])
		@sponsors = @event.sponsors.all
	end

	# GET /sponsors/1
	# GET /sponsors/1.json
	def show
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.find(params[:id])
	end

	# GET /sponsors/new
	# GET /sponsors/new.json
	def new
		session[:return_to] ||= request.referer
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.new
	end

	# GET /sponsors/1/edit
	def edit
		session[:return_to] ||= request.referer
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.find(params[:id])
	end

	# POST /sponsors
	# POST /sponsors.json
	def create
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.new(params[:sponsor])

		if @sponsor.save
			#redirect_to event_sponsor_url(@event,@sponsor), notice: 'Sponsor was successfully created.'
			redirect_to session[:return_to], notice: 'Sponsor was successfully created.'
		else
			render action: "new"
		end
	end

	# PUT /sponsors/1
	# PUT /sponsors/1.json
	def update
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.find(params[:id])

		if @sponsor.update_attributes(params[:sponsor])
			# redirect_to event_sponsor_url(@event,@sponsor), notice: 'Sponsor was successfully updated.'
			redirect_to :back, notice: 'Sponsor was successfully updated.'
		else
			render action: "edit"
		end
	end

	# DELETE /sponsors/1
	# DELETE /sponsors/1.json
	def destroy
		@event = Event.find(params[:event_id])
		@sponsor = @event.sponsors.find(params[:id])
		@sponsor.destroy

		# redirect_to event_sponsors_url(@event)
		redirect_to :back
	end
end
