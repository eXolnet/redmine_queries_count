require File.expand_path('../../test_helper', __FILE__)

class QueriesCountTest < RedmineQueriesCount::IntegrationTest
  fixtures :projects,
           :users, :email_addresses,
           :roles,
           :members,
           :member_roles,
           :trackers,
           :projects_trackers,
           :enabled_modules,
           :issue_statuses,
           :issues,
           :enumerations,
           :custom_fields,
           :custom_values,
           :custom_fields_trackers,
           :attachments

  # create a query
  def test_add_query
    log_user('jsmith', 'jsmith')

    compatible_request :get, '/projects/ecookbook/queries/new'
    assert_response :success

    query = new_record(IssueQuery) do
      compatible_request :post, '/projects/ecookbook/queries',
          :utf8 => "✓",
          :type => "IssueQuery",
          :query => {
            :name => "Test Query",
            :visibility => 0,
            :show_count => 1,
            :group_by => "",
            :sort_criteria => [
              ["id", "desc"],
              ["", ""],
              ["", ""]
            ]
          },
          :default_columns => 1,
          :t => [""],
          :f => ["", "status_id"],
          :op => {
            :status_id => "o"
          }

      # check redirection
      assert_redirected_to :controller => 'issues', :action => 'index', :params => {:query_id => 1}
      follow_redirect!
    end

    # check query attributes
    assert query.show_count

    # check query count is display in the list
    assert_select "#sidebar ul.queries a", text: "Test Query (10)", count: 1
  end
end
