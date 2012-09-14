class MakeEventWorkshopSlugUnique < ActiveRecord::Migration
	def change
		add_index :workshops, [:event_id, :slug], :unique => true
	end
end
