class EventAttendeesController < ApplicationController
	# GET /event_attendees
	# GET /event_attendees.json
	def index
		@event = Event.find(params[:event_id])
		@event_attendees = @event.attendees.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @event_attendees }
		end
	end

	# GET /event_attendees/1
	# GET /event_attendees/1.json
	def show
		@event = Event.find(params[:event_id])
		@event_attendee = @event.attendees.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @event_attendee }
		end
	end

	def register
		require 'pp'
		pp params
		@event = Event.find(params[:event_id])
		@event_attendee = @event.attendees.new
		@event_attendee.event = @event
		@event_attendee.user = current_user

		respond_to do |format|
			if @event_attendee.save
				format.html { redirect_to event_attendee_url(@event,@event_attendee), notice: 'Event attendee was successfully created.' }
				format.json { render json: @event_attendee, status: :created, location: @event_attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# GET /event_attendees/new
	# GET /event_attendees/new.json
	def new
		@event_attendee = EventAttendee.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @event_attendee }
		end
	end

	# GET /event_attendees/1/edit
	def edit
		@event_attendee = EventAttendee.find(params[:id])
	end

	# POST /event_attendees
	# POST /event_attendees.json
	def create
		@event_attendee = EventAttendee.new(params[:event_attendee])

		respond_to do |format|
			if @event_attendee.save
				format.html { redirect_to @event_attendee, notice: 'Event attendee was successfully created.' }
				format.json { render json: @event_attendee, status: :created, location: @event_attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /event_attendees/1
	# PUT /event_attendees/1.json
	def update
		@event_attendee = EventAttendee.find(params[:id])

		respond_to do |format|
			if @event_attendee.update_attributes(params[:event_attendee])
				format.html { redirect_to @event_attendee, notice: 'Event attendee was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /event_attendees/1
	# DELETE /event_attendees/1.json
	def destroy
		@event_attendee = EventAttendee.find(params[:id])
		@event_attendee.destroy

		respond_to do |format|
			format.html { redirect_to event_attendees_url }
			format.json { head :no_content }
		end
	end
end
