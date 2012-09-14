class FixEventSlug < ActiveRecord::Migration
	def change
		change_column :events, :slug, :string, :null => false
	end
end
