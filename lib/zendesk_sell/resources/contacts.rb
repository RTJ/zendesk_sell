module ZendeskSell
  module Resources
    class Contacts < BaseResource
      private

      def endpoint
        '/contacts'
      end

      def resource_type
        'contact'
      end
    end
  end
end