class WorkshopAttendeesController < ApplicationController
	before_filter :find_event_workshop #, :only => [:show, :edit, :update, :destroy]

	# GET /attendees
	# GET /attendees.json
	def index
		@attendees = WorkshopAttendee.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @attendees }
		end
	end

	# GET /attendees/1
	# GET /attendees/1.json
	def show
		@attendee = WorkshopAttendee.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @attendee }
		end
	end

	# GET /attendees/new
	# GET /attendees/new.json
	def new
		#@users_not_attending=@event.attendees.where("id not in (?)", @workshop.attendees.map{ |attendee| attendee.user_id })
		@users_not_attending=User.where("id not in (?)", @workshop.attendees.map{ |attendee| attendee.user_id })
		@attendee = @workshop.attendees.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @attendee }
		end
	end

	# GET /attendees/1/edit
	def edit
		@attendee = @workshop.attendees.find(params[:id])
	end

	# POST /attendees
	# POST /attendees.json
	def create
		@attendee = @workshop.attendees.new(params[:attendee])

		respond_to do |format|
			if @attendee.save
				format.html { redirect_to @attendee, notice: 'Workshop attendee was successfully created.' }
				format.json { render json: @attendee, status: :created, location: @attendee }
			else
				format.html { render action: "new" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /attendees/1
	# PUT /attendees/1.json
	def update
		@attendee = @workshop.attendees.find(params[:id])

		respond_to do |format|
			if @attendee.update_attributes(params[:attendee])
				format.html { redirect_to @attendee, notice: 'Workshop attendee was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @attendee.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /attendees/1
	# DELETE /attendees/1.json
	def destroy
		@attendee = @workshop.attendees.find(params[:id])
		@attendee.destroy

		respond_to do |format|
			format.html { redirect_to attendees_url }
			format.json { head :no_content }
		end
	end

	protected
	def find_event_workshop
		@event = Event.find(params[:event_id])
		@workshop = @event.workshops.find(params[:workshop_id])
	end
end
