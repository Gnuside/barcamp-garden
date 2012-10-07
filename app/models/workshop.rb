class Workshop < ActiveRecord::Base
  attr_accessible :description, :slug, :title, :room_id, :slot_id

  belongs_to :event
  belongs_to :room
  belongs_to :slot

  has_many :attendees, :dependent => :destroy, :class_name => 'WorkshopAttendee'

  validates :slug, :format => { :with => /^[a-z0-9]{5}[a-z0-9]*$/ }
  validates_uniqueness_of :slug, :scope => [:event_id]
end
