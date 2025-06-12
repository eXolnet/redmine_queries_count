require 'redmine'

QUERIES_COUNT_VERSION_NUMBER = '1.5.0'

Redmine::Plugin.register :redmine_queries_count do
  name 'Queries Count'
  author 'eXolnet'
  description 'This plugin allow user to add queries item count in the sidebar.'
  version QUERIES_COUNT_VERSION_NUMBER
  url 'https://github.com/eXolnet/redmine_queries_count'
  author_url 'https://www.exolnet.com'

  requires_redmine :version_or_higher => '5.0'
end

require File.dirname(__FILE__) + '/lib/redmine_queries_count'
