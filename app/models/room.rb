class Room < ActiveRecord::Base
  attr_accessible :event, :name

  belongs_to :event
end
