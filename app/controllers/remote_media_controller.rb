class RemoteMediaController < ApplicationController
  def index
		@event = Event.find(params[:event_id])
		@remote_media = @event.remote_media
  end

  def show
  end

  def updated
		@event = Event.find(params[:event_id])
		@remote_media = @event.remote_media

		# FIXME : search updated media only
  end
end
