# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Tag
      # This family of methods is used to manage user-defined tags. Tags are used to categorize letters
      # based on your own criteria, e. g. to create a distinction between marketing and transactional
      # letters or group together all notifications for a particular order type. UniOne allows you to assign
      # tags to all outgoing emails, and the tags you’ve set may then be used to filter and analyze delivery
      # statistics.
      class TagApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # This method returns the full list of user-defined tags. Does not receive any parameters.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#tag-list
        # @return [::UniOne::Api::Tag::Model::TagListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list
          ::UniOne::Api::Tag::Model::TagListResponse.from_h(@client.call('/tag/list.json'))
        end

        # Removes tag.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#tag-delete
        # @param request [::UniOne::Api::Tag::Model::TagDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/tag/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
