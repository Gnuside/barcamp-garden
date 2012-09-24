class Event < ActiveRecord::Base
  attr_accessible :dtend, :dtstart, :description, :slug, :title

  has_many :remote_media, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  has_many :slots, :dependent => :destroy
  has_many :sponsors, :dependent => :destroy
  has_many :workshops, :dependent => :destroy

  has_many :attendees, :dependent => :destroy, :class_name => 'EventAttendee'

  validates :slug, :format => { :with => /^[a-z0-9]+$/ },
	  :length => { :minimum => 6 }
  validates :title, :length => { :minimum => 6 }
  # FIXME: validate dtend > dtstart
  #
  #
  def current?
	  now = Time.now.utc
	  return (self.dtstart <= now && now <= self.dtend )
  end

  def upcoming?
	  now = Time.now.utc
	  return (now < self.dtstart)
  end

  def past?
	  now = Time.now.utc
	  return (self.dtend < now)
  end

  def validate
	  errors.add(:start_date, 'must be earlier than end date') if
	  self.dtstart < self.dtend
  end
end
