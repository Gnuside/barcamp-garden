class Event < ActiveRecord::Base
  attr_accessible :dtend, :dtstart, :description, :slug, :title

  has_many :slots, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  has_many :workshops, :dependent => :destroy
  has_many :remote_media, :dependent => :destroy

  validates :slug, :format => { :with => /^[a-z0-9]+$/ },
	  :length => { :minimum => 6 }
  validates :title, :length => { :minimum => 6 }
  # FIXME: validate dtend > dtstart
end
