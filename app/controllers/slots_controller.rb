class SlotsController < ApplicationController
	# GET /events/:id/slots
	def index
		@event = Event.find(params[:event_id])
		@slots = @event.slots
	end


	# GET /events/:event_id/slots/:id
	def show
		@event = Event.find(params[:event_id])
		@slot = @event.slots.find(params[:id])
	end


	# GET /events/:event_id/slots/new
	def new
		@event = Event.find(params[:event_id])
		@slot = @event.slots.new

		# Pre-fill with event info
		@slot.dtstart = @event.dtstart
		@slot.dtend = @event.dtend
	end


	# GET /events/:event_id/slots/1/edit
	def edit
		@event = Event.find(params[:event_id])
		@slot = @event.slots.find(params[:id])
	end


	# POST /events/:event_id/slots
	def create
		@event = Event.find(params[:event_id])
		@slot = @event.slots.new(params[:slot])

		if @slot.save
			redirect_to event_slot_url(@event,@slot), 
				notice: 'Room was successfully created.'
		else
			render action: "new"
		end
	end


	# PUT /events/:event_id/slots/1
	def update
		@event = Event.find(params[:event_id])
		@slot = @event.slots.find(params[:id])

		if @slot.update_attributes(params[:slot])
			redirect_to event_slot_url(@event,@slot), 
				notice: 'Room was successfully updated.'
		else
			render action: "edit"
		end
	end


	# DELETE /events/:event_id/slots/:id
	def destroy
		@event = Event.find(params[:event_id])
		@slot = @event.slots.find(params[:id])
		@slot.destroy

		redirect_to event_schedule_url(@event)
	end
end
