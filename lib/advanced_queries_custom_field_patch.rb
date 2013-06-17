require_dependency 'custom_field'

class CustomField
  alias_method :order_statement_without_custom_order, :order_statement
  
  
  def order_statement
    return nil if multiple?
    
    if field_format == 'list' and ! custom_list_order.nil?
    	values = possible_values()
    	
    	if custom_list_order == 'desc'
    		values.reverse!
    	end
    	
    	set = values.collect {|v| "'#{v}'"}.join(',')
    	
    	# Redmine 3.x
    	#return "COALESCE(FIELD(#{join_alias}.value, #{set}), '')"
    	
    	# Redmine 2.x
    	return "COALESCE(FIELD((SELECT cv_sort.value FROM #{CustomValue.table_name} cv_sort" +
          " WHERE cv_sort.customized_type='#{self.class.customized_class.base_class.name}'" +
          " AND cv_sort.customized_id=#{self.class.customized_class.table_name}.id" +
          " AND cv_sort.custom_field_id=#{id} LIMIT 1), #{set}), '')"
    end
    
    order_statement_without_custom_order
  end
end
