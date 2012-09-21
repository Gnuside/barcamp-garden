class EventAttendee < ActiveRecord::Base
  attr_accessible :comment, :event, :user
end
