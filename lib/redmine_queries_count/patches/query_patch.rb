require_dependency 'query'

module RedmineQueriesCount
  module Patches
    module QueryPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          alias_method :build_from_params_without_queries_count, :build_from_params
          alias_method :build_from_params, :build_from_params_with_queries_count
        end
      end

      module InstanceMethods
        def build_from_params_with_queries_count(params, *args)
          build_from_params_without_queries_count(params, *args)

          self.show_count = params[:query] && params[:query][:show_count]

          self
        end
      end
    end
  end
end

unless Query.included_modules.include?(RedmineQueriesCount::Patches::QueryPatch)
  Query.send(:include, RedmineQueriesCount::Patches::QueryPatch)
end
