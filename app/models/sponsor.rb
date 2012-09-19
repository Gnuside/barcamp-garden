class Sponsor < ActiveRecord::Base
  attr_accessible :name, :logo
 
  belongs_to :event
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
