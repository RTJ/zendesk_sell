module ZendeskSell
  module Resources
    class Deals < BaseResource
      private

      def endpoint
        '/deals'
      end

      def resource_type
        'deal'
      end
    end
  end
end