require_dependency 'queries_helper'

module QueriesHelper
  # Renders a group of queries
  def query_links(title, queries)
    return '' if queries.empty?
    # links to #index on issues/show
    url_params = controller_name == 'issues' ? {:controller => 'issues', :action => 'index', :project_id => @project} : {}

    content_tag('h3', title) + "\n" +
      content_tag('ul',
        queries.collect {|query|
            css = 'query'
            css << ' selected' if query == @query
            content_tag('li', link_to(query_link_content(query), url_params.merge(:query_id => query), :class => css))
          }.join("\n").html_safe,
        :class => 'queries'
      ) + "\n"
  end

  # Adds the query issues count to link content
  def query_link_content(query)
    if query.show_issues_count
      query.name + " (" + query.issue_count().to_s + ")"
    else
      query.name
    end
  end
end
