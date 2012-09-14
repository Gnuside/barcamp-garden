class FixEventWorkshopSlug < ActiveRecord::Migration
	def change
		add_index :workshops, [:event_id, :slug], :unique => true
		change_column :workshops, :slug, :string, :null => false
	end
end
