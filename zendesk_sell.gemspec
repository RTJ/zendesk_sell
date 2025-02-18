# frozen_string_literal: true

require_relative "lib/zendesk_sell/version"

Gem::Specification.new do |spec|
  spec.name = "zendesk_sell"
  spec.version = ZendeskSell::VERSION
  spec.authors = ["Eugeniu Tambur"]
  spec.email = ["eugeniu.rtj@gmail.com"]

  spec.summary = "A Ruby client for the Zendesk Sell (Sales CRM) API"
  spec.description = "The zendesk_sell gem provides a robust and modular Ruby interface for interacting with the Zendesk Sell API. It supports full CRUD operations on resources such as leads, deals, contacts, companies, tasks, and users using the Faraday HTTP client."
  spec.homepage = "https://github.com/RTJ/zendesk_sell"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RTJ/zendesk_sell"
  spec.metadata["changelog_uri"] = "https://github.com/RTJ/zendesk_sell/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile]) ||
        f.end_with?('.gem')
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  
end
