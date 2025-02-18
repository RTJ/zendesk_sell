# frozen_string_literal: true
require 'rspec'
require 'webmock/rspec'
require_relative '../lib/zendesk_sell'
require 'json'
require 'zendesk_sell' 

# Disable real HTTP connections; allow localhost if needed.
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.order = 'random'
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
