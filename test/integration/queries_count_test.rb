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
           :queries,
           :time_entries

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

  def test_show_query_count_inside_project_uses_project_scoped_count
    query = IssueQuery.find(5)
    query.update_column(:show_count, true)

    global_count = expected_issue_count(query, User.find(2), nil)
    project_count = expected_issue_count(query, User.find(2), Project.find(1))
    assert_not_equal global_count, project_count

    log_user('jsmith', 'jsmith')
    get '/projects/ecookbook/issues'
    assert_response :success

    assert_select '#sidebar ul.queries a', :text => "Open issues by priority and tracker (#{project_count})", :count => 1
  end

  def test_query_count_is_not_shown_when_show_count_is_disabled
    log_user('jsmith', 'jsmith')
    get '/issues'
    assert_response :success

    assert_select '#sidebar ul.queries a', :text => 'Public query for all projects', :count => 1
    assert_select '#sidebar ul.queries a', :text => /\(\d+\)/, :count => 0
  end

  def test_query_count_respects_issue_visibility
    query = IssueQuery.find(5)
    query.update_column(:show_count, true)

    admin_count = expected_issue_count(query, User.find(1), nil)
    user_count = expected_issue_count(query, User.find(3), nil)
    assert_not_equal admin_count, user_count

    log_user('admin', 'admin')
    get '/issues'
    assert_select '#sidebar ul.queries a', :text => "Open issues by priority and tracker (#{admin_count})", :count => 1

    reset!
    log_user('dlopper', 'foo')
    get '/issues'
    assert_select '#sidebar ul.queries a', :text => "Open issues by priority and tracker (#{user_count})", :count => 1
  end

  def test_issue_index_with_plain_filters_does_not_change_saved_queries
    query = IssueQuery.find(4)
    query.update_column(:show_count, true)

    log_user('jsmith', 'jsmith')
    get '/issues', :params => {:set_filter => '1', :f => ['status_id'], :op => {'status_id' => 'o'}}
    assert_response :success

    assert_equal true, query.reload.show_count
    assert_select '#sidebar ul.queries a', :text => /Public query for all projects \(\d+\)/, :count => 1
  end

  def test_show_time_entry_query_count
    query = TimeEntryQuery.find(10)
    query.update_column(:show_count, true)

    expected = TimeEntry.visible(User.find(2)).joins(:project).
      where(:project_id => 1, :user_id => 2).count
    assert expected > 0

    log_user('jsmith', 'jsmith')
    get '/projects/ecookbook/time_entries'
    assert_response :success

    assert_select '#sidebar ul.queries a', :text => "My spent time (#{expected})", :count => 1
  end

  def test_show_project_query_count
    query = ProjectQuery.find(11)
    query.update_column(:show_count, true)

    expected = Project.visible(User.find(2)).where(:id => User.find(2).memberships.map(&:project_id)).count
    assert expected > 0

    log_user('jsmith', 'jsmith')
    get '/projects'
    assert_response :success

    assert_select '#sidebar ul.queries a', :text => "Projects as list (#{expected})", :count => 1
  end

  private

  def expected_issue_count(query, user, project)
    query = IssueQuery.find(query.id)
    query.project = project
    Issue.visible(user).joins(:status, :project).where(query.statement).count
  end
end
