class RoomsController < ApplicationController
	before_filter :authenticate_user!, :except => [
		:index, :show
	]

	# GET /events/:id/rooms
	def index
		@event = Event.find(params[:event_id])
		@rooms = @event.rooms
	end


	# GET /events/:event_id/rooms/:id
	def show
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])
	end


	# GET /events/:event_id/rooms/new
	def new
		@event = Event.find(params[:event_id])
		@room = @event.rooms.new
	end


	# GET /events/:event_id/rooms/1/edit
	def edit
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])
	end


	# POST /events/:event_id/rooms
	def create
		@event = Event.find(params[:event_id])
		@room = @event.rooms.new(params[:room])

		if @room.save
			redirect_to event_schedule_url(@event), 
				notice: 'Room was successfully created.'
		else
			render action: "new"
		end
	end


	# PUT /events/:event_id/rooms/1
	def update
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])

		if @room.update_attributes(params[:room])
			redirect_to event_schedule_url(@event), 
				notice: 'Room was successfully updated.'
		else
			render action: "edit"
		end
	end


	# DELETE /events/:event_id/rooms/:id
	def destroy
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])
		@room.destroy

		redirect_to event_schedule_url(@event)
	end
end
