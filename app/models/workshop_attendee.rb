class WorkshopAttendee < ActiveRecord::Base
  attr_accessible :comment, :user, :workshop, :user_id

  belongs_to :workshop
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:workshop_id]
end
