module ZendeskSell
  module Resources
    class BaseResource
      def initialize(client)
        @client = client
      end

      # List all resources (supports optional filtering/pagination).
      def list(params = {})
        @client.request(:get, endpoint, params: params)
      end

      # Retrieve a single resource by its ID.
      def find(id, params = {})
        @client.request(:get, "#{endpoint}/#{id}", params: params)
      end

      # Create a new resource.
      # The payload structure follows the Zendesk Sell API's expected format.
      def create(attributes = {})
        payload = { data: attributes }
        @client.request(:post, endpoint, payload: payload)
      end

      # Update an existing resource by its ID.
      def update(id, attributes = {})
        payload = { data: attributes }
        @client.request(:put, "#{endpoint}/#{id}", payload: payload)
      end

      # Delete a resource by its ID.
      def delete(id)
        @client.request(:delete, "#{endpoint}/#{id}")
      end

      # Search for resources using the v3 search endpoint.
      # Accepts a query hash formatted per the v3 Search API.
      #
      # Example query for searching a contact by email:
      #   {
      #     "filter": {
      #       "filter": {
      #         "attribute": { "name": "email" },
      #         "parameter": { "eq": "sell@zendesk.com" }
      #       }
      #     },
      #     "projection": [
      #       { "name": "id" },
      #       { "name": "name" },
      #       { "name": "email" }
      #     ]
      #   }
      def search(query = {}, per_page = 1)
        payload = {
          items: [
            {
              data: { query: query },
              per_page: per_page
            }
          ]
        }
        search_url = "#{@client.base_url_v3}#{endpoint}/search"
        # The client.search_url(endpoint) returns an absolute URL (e.g. "https://api.getbase.com/v3/contacts/search")
        @client.request(:post, search_url, payload: payload)
      end


      private

      # Must be implemented in subclasses (e.g., '/leads', '/deals', etc.).
      def endpoint
        raise NotImplementedError, "You must implement the endpoint method in the subclass"
      end

      # Must be implemented in subclasses (e.g., 'lead', 'deal', etc.).
      def resource_type
        raise NotImplementedError, "You must implement the resource_type method in the subclass"
      end

    end
  end
end