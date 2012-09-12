class Event < ActiveRecord::Base
  attr_accessible :date_end, :date_start, :description, :slug, :title, :slots, :rooms

  has_many :slots, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
end
