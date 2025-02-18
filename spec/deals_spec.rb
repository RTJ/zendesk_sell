# spec/resources/deals_spec.rb
require 'spec_helper'

RSpec.describe ZendeskSell::Resources::Deals do
  let(:client) { instance_double(ZendeskSell::Client) }
  subject { described_class.new(client) }

  describe "#list" do
    it "calls client.request with GET and the '/deals' endpoint" do
      expect(client).to receive(:request).with(:get, '/deals', params: {})
      subject.list
    end
  end

  describe "#find" do
    it "calls client.request with GET and the deal ID appended to the endpoint" do
      id = 456
      expect(client).to receive(:request).with(:get, "/deals/#{id}", params: {})
      subject.find(id)
    end
  end

  describe "#create" do
    it "calls client.request with POST and a properly formatted payload" do
      attributes = { title: 'New Deal', value: 1000 }
      expected_payload = { data: { type: 'deal', attributes: attributes } }
      expect(client).to receive(:request).with(:post, '/deals', payload: expected_payload)
      subject.create(attributes)
    end
  end

  describe "#update" do
    it "calls client.request with PUT and a properly formatted payload" do
      id = 456
      attributes = { title: 'Updated Deal' }
      expected_payload = { data: attributes }
      expect(client).to receive(:request).with(:put, "/deals/#{id}", payload: expected_payload)
      subject.update(id, attributes)
    end
  end

  describe "#delete" do
    it "calls client.request with DELETE for the given deal ID" do
      id = 456
      expect(client).to receive(:request).with(:delete, "/deals/#{id}")
      subject.delete(id)
    end
  end
end