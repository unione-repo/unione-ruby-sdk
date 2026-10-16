# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Project
      # Projects allow you to group several independent domains, webhooks, templates, and unsubscription
      # lists together. It's very useful if you have your own clients and manage their data from a single
      # UniOne account. Each project receives its own API key, and all API calls with that API key only deal
      # with the data of that project. This way, you can assign a separate project for each client and be
      # sure that they won't conflict; e.g. unsubscribing from one project won't affect another.
      #
      # Projects methods are disabled by default due to antispam measures. To enable them, [contact
      # support](https://cp.unione.io/en/support).
      #
      # Please note that sending domains are confirmed and used on per-project basis by default. But it's
      # possible to allow projects to send emails from domains confirmed for main account - just [ask
      # support](https://cp.unione.io/en/support) to enable it.
      class ProjectApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Creates a new project.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#project-create
        # @param request [::UniOne::Api::Project::Model::ProjectCreateRequest, Hash]
        # @return [::UniOne::Api::Project::Model::ProjectCreateResponse]
        # @raise [::UniOne::Client::ApiError]
        def create(request)
          ::UniOne::Api::Project::Model::ProjectCreateResponse.from_h(@client.call('/project/create.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Updates a project.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#project-update
        # @param request [::UniOne::Api::Project::Model::ProjectUpdateRequest, Hash]
        # @return [::UniOne::Api::Project::Model::ProjectUpdateResponse]
        # @raise [::UniOne::Client::ApiError]
        def update(request)
          ::UniOne::Api::Project::Model::ProjectUpdateResponse.from_h(@client.call('/project/update.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Lists projects.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#project-list
        # @param request [::UniOne::Api::Project::Model::ProjectListRequest, Hash]
        # @return [::UniOne::Api::Project::Model::ProjectListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list(request)
          ::UniOne::Api::Project::Model::ProjectListResponse.from_h(@client.call('/project/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Deletes a project.
        #
        # The project will be moved to the "trash bin" before being permanently deleted. You can restore the
        # project by contacting support.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#project-delete
        # @param request [::UniOne::Api::Project::Model::ProjectDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/project/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
