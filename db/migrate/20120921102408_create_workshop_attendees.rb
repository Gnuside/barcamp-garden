class CreateWorkshopAttendees < ActiveRecord::Migration
  def change
    create_table :workshop_attendees do |t|
      t.text :comment
      t.references :user, :null => false
      t.references :workshop, :null => false

      t.timestamps
    end
  end
end
