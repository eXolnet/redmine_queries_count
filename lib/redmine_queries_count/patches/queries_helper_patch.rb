require_dependency 'queries_helper'

module RedmineQueriesCount
  module Patches
    module QueriesHelperPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          alias_method :query_links_without_queries_count, :query_links
          alias_method :query_links, :query_links_with_queries_count
        end
      end

      module InstanceMethods
        def query_links_with_queries_count(title, queries)
          html = Nokogiri::HTML.fragment(query_links_without_queries_count(title, queries))

          queries.each do |query|
            next unless query.show_count

            link = html.at_css("a[href$=\"?query_id=#{query.id}\"]")

            next unless link

            query.project = @project if defined? @project
            link.content = link.content + " (" + query.issue_count().to_s + ")"
          end

          return html.to_html.html_safe
        end
      end
    end
  end
end

unless QueriesHelper.included_modules.include?(RedmineQueriesCount::Patches::QueriesHelperPatch)
  QueriesHelper.send(:include, RedmineQueriesCount::Patches::QueriesHelperPatch)
end
