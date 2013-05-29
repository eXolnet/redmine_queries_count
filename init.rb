require 'redmine'

# Patch the Redmine core
require 'issues_helper_patch'

Redmine::Plugin.register :queries_issues_count do
  name 'Queries Issues Count'
  author 'eXolnet'
  description 'This plugin allow user to add issues count for theirs custom reports.'
  version '1.0.0'
  url 'https://redmine.exolnet.com/projects/redmine-queries-issues-count'
  author_url 'http://www.exolnet.com'
end
