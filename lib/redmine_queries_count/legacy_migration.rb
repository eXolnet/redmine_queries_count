require 'active_record'

module RedmineQueriesCount
  class LegacyMigration
    def self.[](version)
      if ActiveRecord::VERSION::MAJOR < 5
        return ActiveRecord::Migration
      end

      ActiveRecord::Migration[version]
    end
  end
end
