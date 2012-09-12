class Room < ActiveRecord::Base
  attr_accessible :event, :name

  belongs_to :event
  has_many :workshops, :dependent => :destroy
end
