module ZendeskSell
  module Resources
    class Users < BaseResource
      private

      def endpoint
        '/users'
      end

      def resource_type
        'user'
      end
    end
  end
end