class Workshop < ActiveRecord::Base
  attr_accessible :description, :slug, :title, :room_id, :slot_id

  belongs_to :event
  belongs_to :room
  belongs_to :slot
end
