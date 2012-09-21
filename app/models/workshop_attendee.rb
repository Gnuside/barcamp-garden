class WorkshopAttendee < ActiveRecord::Base
  attr_accessible :comment, :user, :workshop

  belongs_to :workshop
  belongs_to :user
end
