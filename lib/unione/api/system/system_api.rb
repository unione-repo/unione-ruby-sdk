# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module System
      # System operations.
      class SystemApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Checks API key validity and returns user ID.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#system-ping
        # @return [::UniOne::Api::System::Model::SystemPingResponse]
        # @raise [::UniOne::Client::ApiError]
        def ping
          ::UniOne::Api::System::Model::SystemPingResponse.from_h(@client.call('/system/ping.json'))
        end

        # Gets user or project info by API key.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#system-info
        # @return [::UniOne::Api::System::Model::SystemInfoResponse]
        # @raise [::UniOne::Client::ApiError]
        def info
          ::UniOne::Api::System::Model::SystemInfoResponse.from_h(@client.call('/system/info.json'))
        end
      end
    end
  end
end
