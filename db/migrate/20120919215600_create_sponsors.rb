class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
	  t.references :event, :null => false
	  t.attachment :logo
      t.timestamps
    end
  end
end
