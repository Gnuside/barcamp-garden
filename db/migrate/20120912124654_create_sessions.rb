class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :title
      t.test :description
      t.string :slug

      t.timestamps
    end
  end
end
