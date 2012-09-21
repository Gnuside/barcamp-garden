class CreateWorkshopAttendees < ActiveRecord::Migration
  def change
    create_table :workshop_attendees do |t|
      t.text :comment
      t.reference :user
      t.reference :workshop

      t.timestamps
    end
  end
end
