class WorkshopsController < ApplicationController
	before_filter :authenticate_user!, :except => [
		:index, :show
	]

	# GET /events/:id/workshops
	def index
		@event = Event.find(params[:event_id])
		@workshops = @event.workshops
	end


	# GET /events/:event_id/workshops/:id
	def show
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.find(params[:id])
	end


	# GET /events/:event_id/workshops/new
	def new
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.new
		@workshop.room_id = params[:room_id]
		@workshop.slot_id = params[:slot_id]
	end


	# GET /events/:event_id/workshops/1/edit
	def edit
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.find(params[:id])
	end


	# POST /events/:event_id/workshops
	def create
		require 'pp'
		pp params
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.new(params[:workshop])

		if @workshop.save
			# FIXME: create etherpad text with workshop description
			redirect_to event_schedule_url(@event), 
				notice: 'Room was successfully created.'
		else
			render action: "new"
		end
	end


	# PUT /events/:event_id/workshops/1
	def update
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.find(params[:id])

		if @workshop.update_attributes(params[:workshop])
			redirect_to event_schedule_url(@event), 
				notice: 'Room was successfully updated.'
		else
			render action: "edit"
		end
	end


	# DELETE /events/:event_id/workshops/:id
	def destroy
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.find(params[:id])
		@workshop.destroy

		redirect_to event_schedule_url(@event)
	end

	private

end
