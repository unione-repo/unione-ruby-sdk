# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module UniOne
  module Client
    # The SDK and its version in the "platform" query parameter of every request.
    PLATFORM = 'ruby-sdk.1.3.0'

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
        api_method = ErrorInfo.method_of(path)
        if @config.api_key.to_s.empty?
          raise invalid_request(api_method, 'the API key is empty: pass the API key of the user or of the project to the client')
        end

        json = encode(api_method, body)
        missing = ErrorInfo.missing(api_method, JSON.parse(json))
        raise invalid_request(api_method, "#{missing} is required") if missing

        uri = URI("#{@config.base_url}/#{path.sub(%r{\A/+}, '')}")
        uri.query = URI.encode_www_form(platform: [@config.platform, PLATFORM].compact.reject(&:empty?).join(','))
        status, raw = send_request(api_method, uri, json)
        status = status.to_i
        raw = raw.to_s
        data = decode(api_method, status, raw)

        if status >= 400 || data['status'] == 'error'
          code = ErrorInfo.code_of(data['code'])
          raise ApiError.new(ErrorInfo.api_message(api_method, data['message'], status, code),
                             http_status: status, error_code: code, response_body: data, api_method: api_method,
                             hint: ErrorInfo.hint(code), kind: ApiError::KIND_API,
                             api_message: data['message']&.to_s)
        end
        data
      end

      private

      def invalid_request(api_method, text)
        ApiError.new("#{api_method}: #{text}", api_method: api_method, kind: ApiError::KIND_INVALID_REQUEST)
      end

      def encode(api_method, body)
        JSON.generate(body || {})
      rescue JSON::GeneratorError => e
        raise invalid_request(api_method, "can not encode the request: #{e.message}")
      end

      def decode(api_method, status, raw)
        begin
          data = JSON.parse(raw)
        rescue JSON::ParserError
          raise ApiError.new("#{api_method}: invalid JSON in response (HTTP #{status}): #{ErrorInfo.quote(raw)}",
                             http_status: status, api_method: api_method, kind: ApiError::KIND_INVALID_RESPONSE)
        end
        return data if data.is_a?(Hash)

        raise ApiError.new("#{api_method}: unexpected response (HTTP #{status}): #{ErrorInfo.quote(raw)}",
                           http_status: status, api_method: api_method, kind: ApiError::KIND_INVALID_RESPONSE)
      end

      def send_request(api_method, uri, body)
        @transport.call('POST', uri, headers, body, @config.timeout)
      rescue ApiError => e
        # an error of a custom transport: it keeps its data and gets the method; a plain ApiError (kind api, no code,
        # no HTTP status) is a network one
        raise unless e.api_method.to_s.empty?

        kind = e.kind
        kind = ApiError::KIND_NETWORK if kind == ApiError::KIND_API && e.error_code.nil? && e.http_status.to_i.zero?
        text = e.message.start_with?("#{api_method}: ") ? e.message : "#{api_method}: #{e.message}"
        raise ApiError.new(text, http_status: e.http_status, error_code: e.error_code, response_body: e.response_body,
                           api_method: api_method, hint: e.hint, kind: kind, api_message: e.api_message)
      rescue Timeout::Error, Errno::ETIMEDOUT
        # Net::OpenTimeout, Net::ReadTimeout, Net::WriteTimeout, a connect timeout of the OS
        raise ApiError.new("#{api_method}: HTTP request timed out after #{@config.timeout} s",
                           api_method: api_method, kind: ApiError::KIND_TIMEOUT)
      rescue StandardError => e
        # Faraday::TimeoutError, HTTP::TimeoutError, ... of a custom transport
        if e.class.ancestors.any? { |c| c.is_a?(Class) && c.name.to_s.include?('Timeout') }
          raise ApiError.new("#{api_method}: HTTP request timed out: #{e.class}: #{e.message}",
                             api_method: api_method, kind: ApiError::KIND_TIMEOUT)
        end

        raise ApiError.new("#{api_method}: HTTP request failed: #{e.class}: #{e.message}",
                           api_method: api_method, kind: ApiError::KIND_NETWORK)
      end
    end
  end
end
