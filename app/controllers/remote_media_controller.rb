class RemoteMediaController < ApplicationController
	layout "application_fullwidth"
	before_filter :authenticate_user!, :except => [
		:index, :show
	]

	def index
		@event = Event.find(params[:event_id])
		@remote_media = @event.remote_media
	end

	def show
		@event = Event.find(params[:event_id])
		@remote_media = @event.remote_media.order("id ASC");
	end

	def updates
		@event = Event.find(params[:event_id])
		@since_id = params[:since_id]
		@remote_media = @event.remote_media.where("id > ?",@since_id).order("id ASC").limit(5);
		# FIXME : search updated media only

		respond_to do |format|
			format.html { render :layout => false }
			format.json { render json: @remote_media }
		end
	end
end
