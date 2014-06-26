require_dependency 'issues_helper'

module IssuesHelper
	def query_links(title, queries)
	    # links to #index on issues/show
	    url_params = controller_name == 'issues' ? {:controller => 'issues', :action => 'index', :project_id => @project} : params
	
	    content_tag('h3', h(title)) +
	      queries.collect {|query|
	          css = 'query'
	          css << ' selected' if query == @query

	          if query.show_issues_count
		          query.project = @project
                          link_to(h(query.name) + " (" + query.issue_count().to_s + ")", url_params.merge(:query_id => query), :class => css)
	          else
	          	link_to(h(query.name), url_params.merge(:query_id => query), :class => css)
	          end
	        }.join('<br />').html_safe
	end
end
