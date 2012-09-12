class RoomsController < ApplicationController
	# GET /events/:id/rooms
	def index
		@event = Event.find(params[:event_id])

		@rooms = @event.rooms

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @rooms }
		end
	end


	# GET /events/:id/rooms/1
	# GET /rooms/1.json
	def show
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @room }
		end
	end


	# GET /rooms/new
	# GET /rooms/new.json
	def new
		@event = Event.find(params[:event_id])
		@room = @event.rooms.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @room }
		end
	end


	# GET /rooms/1/edit
	def edit
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])
	end


	# POST /rooms
	# POST /rooms.json
	def create
		@event = Event.find(params[:event_id])
		@room = @event.rooms.new(params[:room])

		if @room.save
			redirect_to event_room_url(@event,@room), 
				notice: 'Room was successfully created.'
		else
			render action: "new"
		end
	end

	# PUT /rooms/1
	# PUT /rooms/1.json
	def update
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])

		if @room.update_attributes(params[:room])
			redirect_to event_room_url(@event,@room), 
				notice: 'Room was successfully updated.'
		else
			render action: "edit"
		end
	end

	# DELETE /rooms/1
	# DELETE /rooms/1.json
	def destroy
		@event = Event.find(params[:event_id])
		@room = @event.rooms.find(params[:id])
		@room.destroy

		respond_to do |format|
			format.html { redirect_to rooms_url }
			format.json { head :no_content }
		end
	end
end
