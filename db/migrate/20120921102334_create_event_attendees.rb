class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.text :comment
      t.references :user, :null => false
      t.references :event, :null => false

      t.timestamps
    end
  end
end
