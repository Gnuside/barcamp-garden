class Session < ActiveRecord::Base
  attr_accessible :description, :slug, :title
end
