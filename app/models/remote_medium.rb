class RemoteMedium < ActiveRecord::Base
  attr_accessible :author, :description, :platform, :remote_id, :url

  # FIXME: a media could belong to multiple events ?
  belongs_to :event
  validates_uniqueness_of :remote_id, :scope => [:platform]
end
