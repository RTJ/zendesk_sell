module ZendeskSell
  module Errors
    class ApiError < StandardError
      attr_reader :code, :body

      def initialize(response)
        @code = response.code
        @body = response.body

        super("API Error: #{code} - #{body}")
      end
    end

    class ConnectionError < StandardError; end
  end
end