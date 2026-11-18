require File.expand_path('../../test_helper', __FILE__)

class QueryPatchTest < ActiveSupport::TestCase
  fixtures :projects, :enabled_modules,
           :users, :email_addresses,
           :members, :member_roles, :roles,
           :trackers, :projects_trackers, :issue_statuses, :enumerations,
           :issues, :queries

  def test_build_from_params_sets_show_count_from_query_params
    query = IssueQuery.new
    query.build_from_params(:query => {:show_count => '1'})

    assert_equal true, query.show_count
  end

  def test_build_from_params_unsets_show_count_when_unchecked
    query = IssueQuery.new(:show_count => true)
    query.build_from_params(:query => {:show_count => '0'})

    assert_equal false, query.show_count
  end

  def test_build_from_params_without_query_params_does_not_enable_show_count
    query = IssueQuery.new
    query.build_from_params(:set_filter => '1', :f => ['status_id'], :op => {'status_id' => 'o'})

    assert_not query.show_count
    assert_equal({'status_id' => {:operator => 'o', :values => ['']}}, query.filters)
  end
end
