# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Webhook
      # UniOne lets you recieve notifications about email status changes or spam blocks. You provide an URL
      # and every time a watched event occurs we will notify you by submitting a request with JSON data to
      # this URL.
      #
      # You can configure the format of webhook calls (JSON or gzipped JSON), which events you want to be
      # notified of, whether or not you let us groups several events in one request, do you want to receive
      # extra details like SMTP answer or recipient's user agent, etc.
      #
      # Please note that your webhook handler should be able to process at least 5 parallel requests, up to
      # 100 events each (but you can configure the maximum number of parallel connections up to 100, which
      # is recommended).
      #
      # If the URL of your webhook handler is not available (the response is not HTTP 200 OK within 3
      # seconds timeout), the system will repeat requests each 10 minutes during 24 hours, passing extra
      # parameter retry_count. If there were at least 10 events during last 24 hours and all the webhook
      # requests about these events have failed then we consider webhook handler broken and change it's
      # status to inactive automatically. A notification about that is sent to an email [configured in
      # control panel](https://cp.unione.io/en/user/alerting/technical/).
      #
      # The format of webhook request and details of each event are described
      # [here](https://docs.unione.io/en/web-api-ref#callback-format).
      class WebhookApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Sets or edits a [webhook](https://docs.unione.io/en/web-api-ref#webhook), i.e. an event notification
        # handler.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#webhook-set
        # @param request [::UniOne::Api::Webhook::Model::WebhookSetRequest, Hash]
        # @return [::UniOne::Api::Webhook::Model::WebhookSetResponse]
        # @raise [::UniOne::Client::ApiError]
        def set(request)
          ::UniOne::Api::Webhook::Model::WebhookSetResponse.from_h(@client.call('/webhook/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Gets properties of a [webhook](https://docs.unione.io/en/web-api-ref#webhook).
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#webhook-get
        # @param request [::UniOne::Api::Webhook::Model::WebhookGetRequest, Hash]
        # @return [::UniOne::Api::Webhook::Model::WebhookGetResponse]
        # @raise [::UniOne::Client::ApiError]
        def get(request)
          ::UniOne::Api::Webhook::Model::WebhookGetResponse.from_h(@client.call('/webhook/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # List all or some [webhooks](https://docs.unione.io/en/web-api-ref#webhook) (event notification
        # handlers) of a user or a project.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#webhook-list
        # @param request [::UniOne::Api::Webhook::Model::WebhookListRequest, Hash]
        # @return [::UniOne::Api::Webhook::Model::WebhookListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list(request)
          ::UniOne::Api::Webhook::Model::WebhookListResponse.from_h(@client.call('/webhook/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Deletes an event notification handler
        #
        # You can also temporarily deactivate webhook without deleting it by setting it's status to "disabled"
        # in [webhook/set](https://docs.unione.io/en/web-api-ref#webhook-set) method.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#webhook-delete
        # @param request [::UniOne::Api::Webhook::Model::WebhookDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/webhook/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Webhook callback format description.
        # @param body [String] raw body of the incoming request
        # @return [::UniOne::Api::Webhook::Model::WebhookCallback]
        def self.parse_callback(body)
          ::UniOne::Api::Webhook::Model::WebhookCallback.from_h(JSON.parse(body))
        end
      end
    end
  end
end
