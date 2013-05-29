class UpdateQueries < ActiveRecord::Migration
	def up
		add_column :queries, :show_issues_count, :boolean, :default => 0	
	end

	def down
		remove_column :queries, :show_issues_count
	end
end
