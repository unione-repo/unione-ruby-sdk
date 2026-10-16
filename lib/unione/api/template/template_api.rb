# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Template
      # You have the option of storing a template on the UniOne side and then using it by id, which is
      # highly recommended for sending repetitive messages or high volume traffic. UniOne supports two
      # different [template engines](https://docs.unione.io/en/template-engines).
      class TemplateApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Creates or updates an email template.
        #
        # Restrictions:
        # * The maximum request size is 10 MB.
        # * The number of templates is limited to 10000.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#template-set
        # @param request [::UniOne::Api::Template::Model::TemplateSetRequest, Hash]
        # @return [::UniOne::Api::Template::Model::TemplateSetResponse]
        # @raise [::UniOne::Client::ApiError]
        def set(request)
          ::UniOne::Api::Template::Model::TemplateSetResponse.from_h(@client.call('/template/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Gets template properties by it's id.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#template-get
        # @param request [::UniOne::Api::Template::Model::TemplateGetRequest, Hash]
        # @return [::UniOne::Api::Template::Model::TemplateGetResponse]
        # @raise [::UniOne::Client::ApiError]
        def get(request)
          ::UniOne::Api::Template::Model::TemplateGetResponse.from_h(@client.call('/template/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Returns the list of all or some templates of the account.
        #
        # You can iterate thru large list using "offset" and "limit" parameters. When less than "limit"
        # templates are returned then the end of list is reached.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#template-list
        # @param request [::UniOne::Api::Template::Model::TemplateListRequest, Hash]
        # @return [::UniOne::Api::Template::Model::TemplateListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list(request)
          ::UniOne::Api::Template::Model::TemplateListResponse.from_h(@client.call('/template/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Deletes a template by id.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#template-delete
        # @param request [::UniOne::Api::Template::Model::TemplateDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/template/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
