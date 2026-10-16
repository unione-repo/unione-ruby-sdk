# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Suppression
      # Methods for managing suppression lists. An email can be added to suppression list because of
      # unsubscription, bounce or complain.
      class SuppressionApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Adds an email address to the suppression list. You can always remove this address from the
        # suppression list later using the
        # [suppression/delete](https://docs.unione.io/en/web-api-ref#suppression-delete) method.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#suppression-set
        # @param request [::UniOne::Api::Suppression::Model::SuppressionSetRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def set(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/suppression/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Gets a reason and date of email suppression.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#suppression-get
        # @param request [::UniOne::Api::Suppression::Model::SuppressionGetRequest, Hash]
        # @return [::UniOne::Api::Suppression::Model::SuppressionGetResponse]
        # @raise [::UniOne::Client::ApiError]
        def get(request)
          ::UniOne::Api::Suppression::Model::SuppressionGetResponse.from_h(@client.call('/suppression/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Returns a suppression list since provided date.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#suppression-list
        # @param request [::UniOne::Api::Suppression::Model::SuppressionListRequest, Hash]
        # @return [::UniOne::Api::Suppression::Model::SuppressionListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list(request)
          ::UniOne::Api::Suppression::Model::SuppressionListResponse.from_h(@client.call('/suppression/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Deletes an email from suppression list (only records with is_deletable=true). If there are no
        # entries of this email in the suppression list, API error 3003 is returned. If such entries exist but
        # no one can be deleted, API error 3004 is returned. If daily limit of deletes exceeded, API error 906
        # is returned.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#suppression-delete
        # @param request [::UniOne::Api::Suppression::Model::SuppressionDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/suppression/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
