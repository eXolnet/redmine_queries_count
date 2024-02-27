require File.expand_path('../../test_helper', __FILE__)

class EnumerationsControllerTest < ActionController::TestCase
  fixtures :projects, :enabled_modules,
           :users, :email_addresses,
           :members, :member_roles, :roles,
           :trackers, :issue_statuses, :issue_categories, :enumerations, :versions,
           :issues, :custom_fields, :custom_values,
           :queries

  def setup
    @controller = QueriesController.new

    # Configure the logged user
    @request.session[:user_id] = 1
  end

  def test_new_project_query_show_count
    @request.session[:user_id] = 2
    get(:new, :params => {:project_id => 1})
    assert_response :success

    assert_select 'label[for="query_show_count"]', text: 'Show count'
    assert_select 'input[name="query[show_count]"]'
  end

  def test_create_query_with_count
    post(
      :create,
      :params => {
        :project_id => 'ecookbook',
        :default_columns => '1',
        :f => ['status_id', 'assigned_to_id'],
        :op => {
          'assigned_to_id' => '=', 'status_id' => 'o'
        },
        :v => {
          'assigned_to_id' => ['1'], 'status_id' => ['1']
        },
        :query => {
          'name' => 'test_new_project_public_query',
          'visibility' => '2',
          'show_count' => '1',
        }
      }
    )
    q = Query.find_by_name('test_new_project_public_query')
    assert_redirected_to :controller => 'issues', :action => 'index', :project_id => 'ecookbook', :query_id => q
    assert q.show_count
  end

  def test_edit_display_count_checkbox
    get(:edit, :params => {:id => 4})
    assert_response :success

    assert_select 'label[for="query_show_count"]', text: 'Show count'
    assert_select 'input[name="query[show_count]"]'
  end

  def test_update_with_count
    put(
      :update,
      :params => {
        :id => 4,
        :default_columns => '1',
        :fields => ['status_id', 'assigned_to_id'],
        :operators => {
          'assigned_to_id' => '=', 'status_id' => 'o'
        },
        :values => {
          'assigned_to_id' => ['1'], 'status_id' => ['1']
        },
        :query => {
          'name' => 'test_edit_global_public_query',
          'visibility' => '2',
          'show_count' => '1',
        }
      }
    )
    assert_redirected_to :controller => 'issues', :action => 'index', :query_id => 4
    q = Query.find_by_name('test_edit_global_public_query')
    assert q.show_count
  end
end
