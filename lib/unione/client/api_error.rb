# frozen_string_literal: true

module UniOne
  module Client
    # Raised when the API returns an error or the response can not be processed.
    class ApiError < StandardError
      # @return [Integer] HTTP status of the response, 0 when the request was not sent
      attr_reader :http_status
      # @return [Integer, nil] API error code (the "code" field of the error response)
      attr_reader :error_code
      # @return [Hash, nil] decoded error response
      attr_reader :response_body

      def initialize(message, http_status: 0, error_code: nil, response_body: nil)
        super(message)
        @http_status = http_status
        @error_code = error_code
        @response_body = response_body
      end
    end
  end
end
