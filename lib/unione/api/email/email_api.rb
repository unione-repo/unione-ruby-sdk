# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Email
      # This group of methods is related with email sending.
      class EmailApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Sends an email or a bunch of emails
        #
        # While sending you can provide substitutions (merge tags), use a template, turn on read or click
        # tracking, etc.
        #
        # Restrictions:
        # * maximum request size is 10 MB
        # * maximum number of recipients is 500
        # * The symbol '/' is not allowed in attachment names
        #
        # If the list of recipients contains invalid, non-existent, duplicate, or unsubscribed emails, those
        # emails will be returned in the output parameter failed_emails, and the email will be sent to all
        # other valid emails addresses. If all the emails addresses fall into failed_emails, sending will not
        # be carried out and API error 204 will be returned.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#email-send
        # @param request [::UniOne::Api::Email::Model::EmailSendRequest, Hash]
        # @return [::UniOne::Api::Email::Model::EmailSendResponse]
        # @raise [::UniOne::Client::ApiError]
        def send_email(request)
          ::UniOne::Api::Email::Model::EmailSendResponse.from_h(@client.call('/email/send.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Sends an email with (re)subscribe link.
        #
        # This method allows subscription renewal by a former subscriber who has previously unsubscribed, or
        # who is blocked because of complaints. This method sends an email with a new subscription link to a
        # former subscriber. Once the recipient clicks the link, their subscription status is restored.
        # There is a default restriction that limits this method to being used once a day. If you need to
        # resubscribe more often, please ask support about it.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#email-subscribe
        # @param request [::UniOne::Api::Email::Model::EmailSubscribeRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def subscribe(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/email/subscribe.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
