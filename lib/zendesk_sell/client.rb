# lib/zendesk_sell/client.rb
require 'uri'
require 'net/http'
require 'json'

module ZendeskSell
  class Client
    attr_reader :access_token, :base_url, :base_url_v3

    # Initializes the client.
    # - access_token: Your Zendesk Sell access token (or use ENV['SELL_ACCESS_TOKEN']).
    # - base_url: The API base URL (default: 'https://api.getbase.com/v2').
    # - base_url_v3: The API base URL (default: 'https://api.getbase.com/v3').
    def initialize(access_token: ENV.fetch('SELL_ACCESS_TOKEN'))
      @access_token = access_token
      @base_url = "https://api.getbase.com/v2"
      @base_url_v3 = "https://api.getbase.com/v3"
    end

    # Performs an HTTP request using Net::HTTP.
    # - method: Symbol (:get, :post, :put, :patch, :delete).
    # - path: API endpoint path (e.g. '/leads').
    # - params: Query parameters (optional).
    # - payload: Request body payload (optional).
    def request(method, path, params: {}, payload: nil)
      headers = default_headers

      # If the path is already an absolute URL, use it directly.
      uri = if path =~ /\Ahttps?:\/\//
              URI(path)
            elsif path.include?('/v2')
              URI("#{base_url}#{path}")
            elsif path.include?('/v3/')
              URI("#{base_url_v3}#{path}")
            else
              URI("#{base_url}#{path}")
            end

      uri.query = URI.encode_www_form(params) if params.any?

      request_obj = case method.to_s.upcase
                    when "GET"    then Net::HTTP::Get.new(uri)
                    when "POST"   then Net::HTTP::Post.new(uri)
                    when "PATCH"  then Net::HTTP::Patch.new(uri)
                    when "PUT"    then Net::HTTP::Put.new(uri)
                    when "DELETE" then Net::HTTP::Delete.new(uri)
                    else
                      raise "Unsupported HTTP method: #{method}"
                    end

      headers.each { |key, value| request_obj[key] = value }
      request_obj.body = payload.to_json if payload

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      response = http.request(request_obj)

      unless response.is_a?(Net::HTTPSuccess)
        raise Errors::ApiError.new(response)
      end

      JSON.parse(response.body)
    rescue Errors::ApiError => e
      raise e
    rescue StandardError => e
      raise Errors::ConnectionError.new(e.message)
    end

    # Default headers for requests.
    def default_headers
      {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json',
        'Authorization' => "Bearer #{access_token}"
      }
    end

    # Resource accessors.
    def leads
      @leads ||= Resources::Leads.new(self)
    end

    def deals
      @deals ||= Resources::Deals.new(self)
    end

    def contacts
      @contacts ||= Resources::Contacts.new(self)
    end

    def companies
      @companies ||= Resources::Companies.new(self)
    end

    def tasks
      @tasks ||= Resources::Tasks.new(self)
    end

    def users
      @users ||= Resources::Users.new(self)
    end
  end
end