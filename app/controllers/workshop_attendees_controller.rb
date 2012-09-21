class WorkshopAttendeesController < ApplicationController
  # GET /workshop_attendees
  # GET /workshop_attendees.json
  def index
    @workshop_attendees = WorkshopAttendee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workshop_attendees }
    end
  end

  # GET /workshop_attendees/1
  # GET /workshop_attendees/1.json
  def show
    @workshop_attendee = WorkshopAttendee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workshop_attendee }
    end
  end

  # GET /workshop_attendees/new
  # GET /workshop_attendees/new.json
  def new
    @workshop_attendee = WorkshopAttendee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workshop_attendee }
    end
  end

  # GET /workshop_attendees/1/edit
  def edit
    @workshop_attendee = WorkshopAttendee.find(params[:id])
  end

  # POST /workshop_attendees
  # POST /workshop_attendees.json
  def create
    @workshop_attendee = WorkshopAttendee.new(params[:workshop_attendee])

    respond_to do |format|
      if @workshop_attendee.save
        format.html { redirect_to @workshop_attendee, notice: 'Workshop attendee was successfully created.' }
        format.json { render json: @workshop_attendee, status: :created, location: @workshop_attendee }
      else
        format.html { render action: "new" }
        format.json { render json: @workshop_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workshop_attendees/1
  # PUT /workshop_attendees/1.json
  def update
    @workshop_attendee = WorkshopAttendee.find(params[:id])

    respond_to do |format|
      if @workshop_attendee.update_attributes(params[:workshop_attendee])
        format.html { redirect_to @workshop_attendee, notice: 'Workshop attendee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workshop_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshop_attendees/1
  # DELETE /workshop_attendees/1.json
  def destroy
    @workshop_attendee = WorkshopAttendee.find(params[:id])
    @workshop_attendee.destroy

    respond_to do |format|
      format.html { redirect_to workshop_attendees_url }
      format.json { head :no_content }
    end
  end
end
