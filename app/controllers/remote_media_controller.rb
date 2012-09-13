class RemoteMediaController < ApplicationController
	layout "application_fullwidth"

	def index
		@event = Event.find(params[:event_id])
		@remote_media = @event.remote_media
	end

	def show
	end

	def updates
		@event = Event.find(params[:event_id])
		@since_id = params[:since_id]
		@remote_media = @event.remote_media.where("id >= ?",@since_id).order("id ASC").limit(5);
		# FIXME : search updated media only

		respond_to do |format|
			format.html { render :layout => false }
			format.json { render json: @authentication }
		end
	end
end
