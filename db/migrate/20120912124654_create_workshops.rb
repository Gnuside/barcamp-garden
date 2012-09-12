class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.string :slug

      t.references :event, :null=> false
      t.references :room, :null=> false
      t.references :slot, :null=> false

      t.timestamps
    end
  end
end
