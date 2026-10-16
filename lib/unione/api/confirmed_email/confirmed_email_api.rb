# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module ConfirmedEmail
      # Manage email addresses confirmed for sandbox-domain sending. These methods are available only with a
      # main account API key.
      class ConfirmedEmailApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Adds an email address and sends a confirmation link.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#confirmed-email-create
        # @param request [::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailRequest, Hash]
        # @return [::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailCreateResponse]
        # @raise [::UniOne::Client::ApiError]
        def create(request)
          ::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailCreateResponse.from_h(@client.call('/confirmed-email/create.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Lists confirmed and unconfirmed email addresses for the account.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#confirmed-email-list
        # @return [::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list
          ::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailListResponse.from_h(@client.call('/confirmed-email/list.json'))
        end

        # Deletes an email address from the account's confirmed email list.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#confirmed-email-delete
        # @param request [::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailRequest, Hash]
        # @return [::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailDeleteResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmailDeleteResponse.from_h(@client.call('/confirmed-email/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
