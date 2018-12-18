class UpdateQueries < ActiveRecord::Migration
  def up
    add_column :queries, :show_count, :boolean, :default => true
  end

  def down
    remove_column :queries, :show_count
  end
end
