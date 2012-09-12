class RemoteMediaController < ApplicationController
  def index
		@event = Event.find(params[:event_id])
		@media = @event.media
  end

  def show
  end
end
