module ZendeskSell
  module Resources
    class Leads < BaseResource
      private

      def endpoint
        '/leads'
      end

      def resource_type
        'lead'
      end
    end
  end
end