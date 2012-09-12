class CreateRemoteMedia < ActiveRecord::Migration
  def change
    create_table :remote_media do |t|
      t.string :platform
      t.string :remote_id
      t.string :url
      t.string :description
      t.string :author

      t.timestamps
    end
  end
end
