class RemoteMedia < ActiveRecord::Base
  attr_accessible :author, :description, :platform, :remote_id, :url
end
