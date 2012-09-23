class EventAttendeesController < ApplicationController

	before_filter :authenticate_user!, :except => [:show,:index]
	
	# GET /event_attendees
	# GET /event_attendees.json
	def index
		@event = Event.find(params[:event_id])
		@attendees = @event.attendees.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @attendees }
		end
	end

	# GET /event_attendees/1
	# GET /event_attendees/1.json
	def show
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @attendee }
		end
	end

	def register
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.new
		@attendee.event = @event
		@attendee.user = current_user

		respond_to do |format|
			if @attendee.save
				format.html { redirect_to event_attendee_url(@event,@attendee), notice: 'Event attendee was successfully created.' }
				format.json { render json: @attendee, status: :created, location: @attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	def unregister
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(current_user)
	end

	# GET /event_attendees/new
	# GET /event_attendees/new.json
	def new
		@event = Event.find(params[:event_id])
		@users_not_attending=User.where("id not in (?)", @event.attendees.map{ |attendee| attendee.user_id })
		@attendee = @event.attendees.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @attendee }
		end
	end

	# POST /event_attendees
	# POST /event_attendees.json
	def create
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.new(params[:attendee])

		respond_to do |format|
			if @attendee.save
				format.html { redirect_to @attendee, notice: 'Event attendee was successfully created.' }
				format.json { render json: @attendee, status: :created, location: @attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /event_attendees/1
	# PUT /event_attendees/1.json
	def update
		@event = Event.find(params[:event_id])
		@attendee = @event.attendees.find(params[:id])

		respond_to do |format|
			if @attendee.update_attributes(params[:event_attendee])
				format.html { redirect_to @attendee, notice: 'Event attendee was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /event_attendees/1
	# DELETE /event_attendees/1.json
	def destroy
		@attendee = EventAttendee.find(params[:id])
		@attendee.destroy

		respond_to do |format|
			format.html { redirect_to event_attendees_url }
			format.json { head :no_content }
		end
	end
end
