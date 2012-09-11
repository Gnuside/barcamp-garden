class Slot < ActiveRecord::Base
  attr_accessible :dtend, :dtstart, :event

  belongs_to :event
end
