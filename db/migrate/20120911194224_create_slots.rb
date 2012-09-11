class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :dtstart
      t.datetime :dtend
      t.reference :event

      t.timestamps
    end
  end
end
