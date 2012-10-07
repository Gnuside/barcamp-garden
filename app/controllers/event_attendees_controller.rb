class EventAttendeesController < ApplicationController

	before_filter :find_event
	before_filter :authenticate_user!, :except => [:index]


	# GET /event_attendees
	# GET /event_attendees.json
	def index
		@attendees = @event.attendees.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @attendees }
		end
	end

	def register
		@attendee = @event.attendees.new
		@attendee.event = @event
		@attendee.user = current_user

		respond_to do |format|
			if @attendee.save
				format.html { redirect_to event_attendees_url(@event), notice: 'Registration successful.' }
				format.json { render json: @attendee, status: :created, location: @attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	def unregister
		@attendee = @event.attendees.where('user_id = ?',current_user.id)
		@attendee.destroy(@attendee)

		respond_to do |format|
			format.html { redirect_to event_attendees_url(@event), notice: 'Unregistration successful.' }
			format.json { head :no_content }
		end
	end

	# GET /event_attendees/new
	# GET /event_attendees/new.json
	def new
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
		@attendee = @event.attendees.new(params[:attendee])

		respond_to do |format|
			if @attendee.save
				format.html { redirect_to event_attendees_url(@event), notice: 'Event attendee was successfully created.' }
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
			format.html { redirect_to :controller => :event_attendees, :action => :index, :event_id => @event }
			format.json { head :no_content }
		end
	end

	private
	def find_event
		@event = Event.find(params[:event_id])
	end
end
