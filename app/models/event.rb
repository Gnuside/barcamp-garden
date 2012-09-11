class Event < ActiveRecord::Base
  attr_accessible :date_end, :date_start, :description, :slug, :title
end
