# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module UniOne
  module Client
    # The SDK and its version in the "platform" query parameter of every request.
    PLATFORM = 'ruby-sdk.1.2.4'

    # Default transport (HTTP layer of ApiClient): Net::HTTP of the standard library.
    #
    # A transport is any object responding to call(method, uri, headers, body, timeout) -> [status, body]
    # (a lambda works too): method 'POST', uri [URI::HTTP] with the query string, headers [Hash] with the API key,
    # body [String] JSON, timeout [Numeric] seconds; it returns the HTTP status [Integer] and the raw response body
    # [String]. HTTP error statuses are returned, not raised; any exception becomes an ApiError.
    class NetHttpTransport
      def call(method, uri, headers, body, timeout)
        request = Net::HTTPGenericRequest.new(method, true, true, uri)
        headers.each { |name, value| request[name] = value }
        request.body = body
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https',
                                                       open_timeout: timeout, read_timeout: timeout) do |http|
          http.request(request)
        end
        [response.code.to_i, response.body.to_s]
      end
    end

    # Low level client: every API method is a POST request with a JSON body that returns JSON.
    class ApiClient
      # @return [Configuration]
      attr_reader :config
      # @return [#call] HTTP layer, see NetHttpTransport
      attr_reader :transport

      # @param config [Configuration]
      # @param transport [#call, nil] call(method, uri, headers, body, timeout) -> [status, body]; nil: NetHttpTransport
      def initialize(config, transport: nil)
        @config = config
        @transport = transport || NetHttpTransport.new
      end

      # Headers of every request: JSON, User-Agent, the API key, then Configuration#headers.
      # @return [Hash{String => String}]
      def headers
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'User-Agent' => @config.user_agent,
          'X-API-KEY' => @config.api_key
        }.merge((@config.headers || {}).transform_keys(&:to_s))
      end

      # Calls an API method, e.g. call('/email/send.json', {...}), and returns the decoded response.
      # @raise [ApiError]
      def call(path, body = {})
        uri = URI("#{@config.base_url}/#{path.sub(%r{\A/+}, '')}")
        uri.query = URI.encode_www_form(platform: [@config.platform, PLATFORM].compact.reject(&:empty?).join(','))
        status, raw = send_request(uri, JSON.generate(body || {}))
        status = status.to_i
        raw = raw.to_s
        begin
          data = JSON.parse(raw)
        rescue JSON::ParserError => e
          raise ApiError.new("Invalid JSON in response (HTTP #{status}): #{raw[0, 500]} (#{e.message})",
                             http_status: status)
        end
        raise ApiError.new("Unexpected response (HTTP #{status}): #{raw[0, 500]}", http_status: status) unless data.is_a?(Hash)

        if status >= 400 || data['status'] == 'error'
          code = data['code']
          raise ApiError.new((data['message'] || 'API error').to_s,
                             http_status: status,
                             error_code: code.to_s =~ /\A\d+\z/ ? code.to_i : nil,
                             response_body: data)
        end
        data
      end

      private

      def send_request(uri, body)
        @transport.call('POST', uri, headers, body, @config.timeout)
      rescue ApiError
        raise
      rescue StandardError => e
        raise ApiError.new("HTTP request failed: #{e.class}: #{e.message}")
      end
    end
  end
end
