migration_class = ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[4.2] : ActiveRecord::Migration

class UpdateQueries < migration_class
  def up
    add_column :queries, :show_count, :boolean, :default => false
  end

  def down
    remove_column :queries, :show_count
  end
end
