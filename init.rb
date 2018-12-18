require 'redmine'

QUERIES_COUNT_VERSION_NUMBER = '1.1.1'

Redmine::Plugin.register :redmine_queries_count do
  name 'Queries Count'
  author 'eXolnet'
  description 'This plugin allow user to add queries item count in the sidebar.'
  version QUERIES_COUNT_VERSION_NUMBER
  url 'https://github.com/eXolnet/redmine-queries-count'
  author_url 'https://www.exolnet.com'

  requires_redmine :version_or_higher => '3.3'
end

require 'redmine_queries_count'
