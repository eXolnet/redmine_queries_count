require File.expand_path('../../test_helper', __FILE__)

class QueriesCountTest < Redmine::IntegrationTest
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

    get '/projects/ecookbook/queries/new'
    assert_response :success

    query = new_record(IssueQuery) do
      post '/projects/ecookbook/queries', :params => {
          :utf8 => "✓",
          :type => "IssueQuery",
          :query => {
            :name => "Test",
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
        }
    end
    # check redirection
    assert_redirected_to :controller => 'issues', :action => 'index', :params => {:query_id => 1}
    follow_redirect!

    # check query attributes
    assert query.show_count
  end
end
