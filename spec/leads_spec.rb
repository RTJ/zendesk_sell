# spec/resources/leads_spec.rb
require 'spec_helper'

RSpec.describe ZendeskSell::Resources::Leads do
  let(:client) { instance_double(ZendeskSell::Client) }
  subject { described_class.new(client) }

  describe "#list" do
    it "calls client.request with GET and the '/leads' endpoint" do
      expect(client).to receive(:request).with(:get, '/leads', params: {})
      subject.list
    end
  end

  describe "#find" do
    it "calls client.request with GET and the lead ID appended to the endpoint" do
      id = 123
      expect(client).to receive(:request).with(:get, "/leads/#{id}", params: {})
      subject.find(id)
    end
  end

  describe "#create" do
    it "calls client.request with POST and a properly formatted payload" do
      attributes = { name: 'Test Lead' }
      expected_payload = { data: { type: 'lead', attributes: attributes } }
      expect(client).to receive(:request).with(:post, '/leads', payload: expected_payload)
      subject.create(attributes)
    end
  end

  describe "#update" do
    it "calls client.request with PUT and a properly formatted payload" do
      id = 123
      attributes = { name: 'Updated Lead' }
      # Update method now sends a payload as { data: attributes }
      expected_payload = { data: attributes }
      expect(client).to receive(:request).with(:put, "/leads/#{id}", payload: expected_payload)
      subject.update(id, attributes)
    end
  end

  describe "#delete" do
    it "calls client.request with DELETE for the given lead ID" do
      id = 123
      expect(client).to receive(:request).with(:delete, "/leads/#{id}")
      subject.delete(id)
    end
  end
end