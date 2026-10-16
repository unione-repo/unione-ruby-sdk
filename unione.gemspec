# frozen_string_literal: true

require_relative 'lib/unione/version'

Gem::Specification.new do |spec|
  spec.name = 'unione'
  spec.version = UniOne::VERSION
  spec.summary = 'UniOne Web API client library for Ruby'
  spec.authors = ['UniOne']
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/unione-repo/unione-ruby-sdk'
  spec.metadata = { 'documentation_uri' => 'https://docs.unione.io/en/web-api-ref' }
  spec.required_ruby_version = '>= 2.7'
  spec.files = Dir['lib/**/*.rb', 'docs/*.md', 'README.md', 'AGENTS.md', 'LICENSE']
  spec.require_paths = ['lib']
end
