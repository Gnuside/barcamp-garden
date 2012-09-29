class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
	  :admin, :avatar, :firstname, :lastname
  # attr_accessible :title, :body
  
  has_many :authentications

  has_many :event_attendees, :dependent => :destroy
  has_many :events, :through => :event_attendees

  has_many :workshop_attendees, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_attached_file :avatar, :styles => { 
	  :big => '600x600>', 
	  :medium => "300x300>", 
	  :thumb => "100x100#", 
	  :small => "48x48#" 
  }

  def name
	  self.email
  end

  def attends_to? event
	  self.events.where('event_id = ?',event.id).first
  end
end
