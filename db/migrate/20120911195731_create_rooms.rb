class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :event, :null => false

      t.timestamps
    end
  end
end
