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
           :attachments,
           :queries

  # create a query
  def test_show_query_count
    log_user('jsmith', 'jsmith')

    query = Query.find_by_name('Public query for all projects')

    query.show_count = true
    query.save!

    compatible_request :get, '/issues'
    assert_response :success

    # check query count is display in the list
    assert_select "#sidebar ul.queries a", text: /Public query for all projects \(\d+\)/, count: 1
  end
end
