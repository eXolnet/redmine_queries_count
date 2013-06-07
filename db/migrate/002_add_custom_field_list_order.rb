class AddCustomFieldListOrder < ActiveRecord::Migration
	def up
		add_column :custom_fields, :custom_list_order, :string, :null => true, :default => nil	
	end

	def down
		remove_column :custom_fields, :custom_list_order
	end
end
