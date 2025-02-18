# frozen_string_literal: true

require "zendesk_sell/version"
require 'faraday'
require 'json'

require 'zendesk_sell/client'
require 'zendesk_sell/errors'
require 'zendesk_sell/resources/base_resource'
require 'zendesk_sell/resources/leads'
require 'zendesk_sell/resources/deals'
require 'zendesk_sell/resources/contacts'
require 'zendesk_sell/resources/companies'
require 'zendesk_sell/resources/tasks'
require 'zendesk_sell/resources/users'

module ZendeskSell
  class Error < StandardError; end
  # Your code goes here...
end
