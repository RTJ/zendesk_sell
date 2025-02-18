# spec/client_spec.rb
require 'spec_helper'

RSpec.describe ZendeskSell::Client do
  let(:access_token) { 'test_token' }
  let(:base_url)     { 'https://api.getbase.com/v2' }
  let(:base_url_v3)  { 'https://api.getbase.com/v3' }
  subject { described_class.new(access_token: access_token) }

  describe "default headers" do
    it "sets the correct Content-Type, Accept, and Authorization headers" do
      headers = subject.send(:default_headers)
      expect(headers['Content-Type']).to eq('application/json')
      expect(headers['Accept']).to eq('application/json')
      expect(headers['Authorization']).to eq("Bearer #{access_token}")
    end
  end

  describe "#request" do
    context "when the response is successful" do
      before do
        stub_request(:get, "#{base_url}/test").
          with(
            headers: {
              'Content-Type'  => 'application/json',
              'Accept'        => 'application/json',
              'Authorization' => "Bearer #{access_token}"
            }
          ).to_return(
            status: 200,
            body: '{"data": "test"}',
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it "returns the parsed JSON body" do
        response = subject.request(:get, '/test')
        expect(response).to eq("data" => "test")
      end
    end

    context "when the response is not successful" do
      before do
        stub_request(:get, "#{base_url}/fail").
          with(
            headers: {
              'Content-Type'  => 'application/json',
              'Accept'        => 'application/json',
              'Authorization' => "Bearer #{access_token}"
            }
          ).
          to_return(
            status: 404,
            body: '{"errors":[{"error":{"code":"not_found","message":"Not Found"}}]}',
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it "raises an ApiError" do
        expect { subject.request(:get, '/fail') }.
          to raise_error(ZendeskSell::Errors::ApiError)
      end
    end

    context "when a network error occurs" do
      before do
        # Simulate a network error on the underlying Net::HTTP request.
        allow_any_instance_of(Net::HTTP).to receive(:request).and_raise(StandardError.new("connection failed"))
      end

      it "raises a ConnectionError" do
        expect { subject.request(:get, '/error') }.
          to raise_error(ZendeskSell::Errors::ConnectionError, /connection failed/)
      end
    end
  end
end