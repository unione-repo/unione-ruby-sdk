# frozen_string_literal: true

module UniOne
  module Client
    # Raised when the API returns an error, the request fails or is invalid, or the response can not be processed.
    # The message names the API method and, for an API error, the code, the HTTP status and how to fix it:
    # "email/send: Unknown recipient (API error 204, HTTP 400). Fix: ... See ...#api-errors".
    class ApiError < StandardError
      # The API returned an error (error_code, hint)
      KIND_API = 'api'
      # The request could not be sent or the response could not be received
      KIND_NETWORK = 'network'
      # The request timed out
      KIND_TIMEOUT = 'timeout'
      # The response is not the JSON of the API (a proxy page, a broken body)
      KIND_INVALID_RESPONSE = 'invalid_response'
      # Found before sending (an empty API key, a required field missing): no request was sent
      KIND_INVALID_REQUEST = 'invalid_request'

      # @return [Integer] HTTP status of the response, 0 when the request was not sent
      attr_reader :http_status
      # @return [Integer, nil] API error code (the "code" field of the error response)
      attr_reader :error_code
      # @return [Hash, nil] decoded error response
      attr_reader :response_body
      # @return [String] API method of the request, e.g. "email/send"; empty when unknown
      #   (not "method": that is Object#method)
      attr_reader :api_method
      # @return [String, nil] how to fix the API error (the errors table of the docs), nil when unknown
      attr_reader :hint
      # @return [String] what failed: one of the KIND_* constants
      attr_reader :kind
      # @return [String, nil] the API's own error message (the "message" of the error response) as is, nil when there
      #   was no API response; #message is the decorated one
      attr_reader :api_message

      def initialize(message, http_status: 0, error_code: nil, response_body: nil, api_method: '', hint: nil,
                     kind: KIND_API, api_message: nil)
        super(message)
        @api_message = api_message
        @http_status = http_status
        @error_code = error_code
        @response_body = response_body
        @api_method = api_method
        @hint = hint
        @kind = kind
      end

      # A repeat of the request may succeed: a network error, a timeout, HTTP 429 or 5xx.
      # @return [Boolean]
      def retryable?
        case @kind
        when KIND_NETWORK, KIND_TIMEOUT then true
        when KIND_API, KIND_INVALID_RESPONSE then @http_status == 429 || @http_status >= 500
        else false
        end
      end
    end
  end
end
