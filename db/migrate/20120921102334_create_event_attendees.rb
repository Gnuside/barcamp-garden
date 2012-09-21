class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.text :comment
      t.reference :user
      t.reference :event

      t.timestamps
    end
  end
end
