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
    	
    	return "COALESCE(FIELD(#{join_alias}.value, #{set}), '')"
    end
    
    order_statement_without_custom_order
  end
end
