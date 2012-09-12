class RemoteMedia < ActiveRecord::Base
  attr_accessible :author, :description, :platform, :remote_id, :url

  validates_uniqueness_of :remote_id, :scope => [:platform]
end
