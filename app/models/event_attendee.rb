class EventAttendee < ActiveRecord::Base
  attr_accessible :comment, :event, :user

  belongs_to :event
  belongs_to :user
end
