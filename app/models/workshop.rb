class Workshop < ActiveRecord::Base
  attr_accessible :description, :slug, :title

  belongs_to :event
  belongs_to :room
  belongs_to :slot
end
