require File.expand_path('../../test_helper', __FILE__)

class QueriesHelperPatchTest < Redmine::HelperTest
  include QueriesHelper

  fixtures :projects, :enabled_modules,
           :users, :members, :member_roles, :roles,
           :trackers, :projects_trackers, :issue_statuses, :enumerations,
           :issues, :queries

  def test_query_links_skips_query_without_matching_link
    query = IssueQuery.find(5)
    query.show_count = true
    query.expects(:issue_count).never

    stubs(:query_links_without_queries_count).returns('<h3>Queries</h3><ul class="queries"></ul>')

    html = query_links('Queries', [query])

    assert_equal '<h3>Queries</h3><ul class="queries"></ul>', html
  end
end
