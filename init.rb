require 'redmine'

# Patch the Redmine core
if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
	require 'advanced_queries_issues_helper_patch'
	require 'advanced_queries_custom_field_patch'
end

# Configure our plugin
Redmine::Plugin.register :queries_issues_count do
  name 'Queries Issues Count'
  author 'eXolnet'
  description 'This plugin allow user to add issues count for theirs custom reports.'
  version '1.0.0'
  url 'https://redmine.exolnet.com/projects/redmine-queries-issues-count'
  author_url 'http://www.exolnet.com'
end
