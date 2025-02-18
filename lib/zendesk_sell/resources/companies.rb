module ZendeskSell
  module Resources
    class Companies < BaseResource
      private

      def endpoint
        '/companies'
      end

      def resource_type
        'company'
      end
    end
  end
end