class Authentication < ActiveRecord::Base
  attr_accessible :index, :provider, :uid, :user_id
  belongs_to :user
end
