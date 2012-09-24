class AddNameToUser < ActiveRecord::Migration
  def change
	  add_column :users, :firstname, :string
	  change_column :users, :firstname, :string, :null=>false
	  add_column :users, :lastname, :string, :null=>false	
	  change_column :users, :lastname, :string, :null=>false
	  add_column :users, :company, :string
  end
end
