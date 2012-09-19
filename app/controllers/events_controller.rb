class EventsController < ApplicationController
	before_filter :authenticate_user!, :except => [
		:index, 
		:show, 
		:show_featured, 
		:show_featured_missing, 
		:show_featured_remote_media, 
		:show_featured_schedule,
		:show_schedule
	]

	# GET /events
	# GET /events.json
	def index
		@events = Event.all
	end


	# GET /events/1
	# GET /events/1.json
	def show
		@event = Event.find(params[:id])
	end


	def show_featured_missing
	end


	def show_featured
		@event = Event.first
		if @event.nil? then
			redirect_to :action => "show_featured_missing"
			return
		end

		redirect_to :action => "show", :id => @event.id
	end


	def show_featured_remote_media
		@event = Event.first
		if @event.nil? then
			redirect_to :action => "show_featured_missing"
			return
		end

		redirect_to event_remote_media_url(:event_id => @event.id)
	end

	def show_featured_schedule
		@event = Event.first
		if @event.nil? then
			redirect_to :action => "show_featured_missing"
			return
		end

		redirect_to :action => "show_schedule", :id => @event.id
	end


	# GET /events/:id/schedule
	def show_schedule
		@event = Event.find(params[:id])

		@rooms = @event.rooms
		@slots = @event.slots
		@workshops = @event.workshops
	end


	# GET /events/new
	# GET /events/new.json
	def new
		@event = Event.new
	end

	# GET /events/1/edit
	def edit
		@event = Event.find(params[:id])
	end

	# POST /events
	# POST /events.json
	def create
		@event = Event.new(params[:event])

		if @event.save
			redirect_to @event, notice: 'Event was successfully created.'
		else
			render action: "new"
		end
	end

	# PUT /events/1
	# PUT /events/1.json
	def update
		@event = Event.find(params[:id])

		if @event.update_attributes(params[:event])
			redirect_to @event, notice: 'Event was successfully updated.'
		else
			render action: "edit"
		end
	end

	# DELETE /events/1
	# DELETE /events/1.json
	def destroy
		@event = Event.find(params[:id])
		@event.destroy

		redirect_to events_url
	end
end
