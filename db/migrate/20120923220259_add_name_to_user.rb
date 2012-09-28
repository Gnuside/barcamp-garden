class AddNameToUser < ActiveRecord::Migration
  def up
	  add_column :users, :firstname, :string
	  add_column :users, :lastname, :string
	  add_column :users, :company, :string
	  for user in User.all
		  if user.firstname.nil? then
			  user.update_attribute(:firstname, 'Anonymous')
			  puts "Updated user #{user.id} with firstname #{user.firstname}"
		  end
		  if user.lastname.nil? then
			  user.update_attribute(:lastname, 'Anonymous')
			  puts "Updated user #{user.id} with lastname #{user.lastname}"
		  end
	  end
	  change_column :users, :firstname, :string, :null=>false
	  change_column :users, :lastname, :string, :null=>false
  end

  def down
	  remove_column :users, :firstname, :string
	  remove_column :users, :lastname, :string, :null=>false	
	  remove_column :users, :company, :string
  end
end
