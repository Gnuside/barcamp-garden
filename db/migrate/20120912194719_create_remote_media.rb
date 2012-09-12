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
	add_index :remote_media, [:platform, :remote_id], :unique => true
  end
end
