module ZendeskSell
  module Resources
    class Tasks < BaseResource
      private

      def endpoint
        '/tasks'
      end

      def resource_type
        'task'
      end
    end
  end
end