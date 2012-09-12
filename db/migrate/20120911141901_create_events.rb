class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :slug
      t.text :description

      t.datetime :dtstart
      t.datetime :dtend

      t.timestamps
    end
  end
end
