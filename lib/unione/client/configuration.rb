# frozen_string_literal: true

module UniOne
  module Client
    # API connection settings.
    class Configuration
      DEFAULT_BASE_URL = 'https://api.unione.io/en/transactional/api/v1'
      # API host api.unione.io
      HOST_API = 'api.unione.io'
      # API host eu1.unione.io
      HOST_EU1 = 'eu1.unione.io'
      # API host us1.unione.io
      HOST_US1 = 'us1.unione.io'
      # Path of the API on every host
      BASE_PATH = '/en/transactional/api/v1'

      # Base URL for an API host: 'eu1.unione.io' -> 'https://eu1.unione.io' + BASE_PATH; a full URL is kept as is.
      def self.base_url_for(host)
        return host.sub(%r{/+\z}, '') if host.include?('://')

        "https://#{host.gsub(%r{\A/+|/+\z}, '')}#{BASE_PATH}"
      end

      # @return [String] user or project API key, sent in the X-API-KEY header
      attr_accessor :api_key
      # @return [String] base URL of the API
      attr_accessor :base_url
      # @return [Integer] request timeout in seconds
      attr_accessor :timeout
      # @return [String]
      attr_accessor :user_agent
      # @return [String, nil] package that uses the SDK and its version (e.g. 'rails.1.0.0'), sent in the "platform" query
      #   parameter before the SDK one (Client::PLATFORM)
      attr_accessor :platform
      # @return [Hash{String => String}] extra HTTP headers of every request (e.g. a tracing id); they override the
      #   default ones of the same name
      attr_accessor :headers

      def initialize(api_key, base_url: DEFAULT_BASE_URL, timeout: 30, user_agent: 'unione-ruby-sdk/1.2.3', platform: nil, headers: {})
        @api_key = api_key
        @base_url = base_url.sub(%r{/+\z}, '')
        @timeout = timeout
        @user_agent = user_agent
        @platform = platform
        @headers = headers || {}
      end
    end
  end
end
