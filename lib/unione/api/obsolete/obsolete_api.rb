# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module Obsolete
      # Obsolete methods dealing with unsubscribes. We recommend using the more flexible
      # [suppression](https://docs.unione.io/en/web-api-ref#suppression) methods instead. Note that you
      # can't resubscribe an unsubscribed recipient using WebAPI, but you can send him an email with
      # subscription link using email/subscribe method.
      class ObsoleteApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Registers a new unsubscribed email.
        #
        # After registering an email as unsubscribed all future attempts to send a message to this email will
        # be rejected. Please note that there's no way to remove an email from unsubscribed thru the API. But
        # you can send an email with a link to resubscribe using
        # [email/subscribe](https://docs.unione.io/en/web-api-ref#email-subscribe) method or remove
        # "unsubscribed" status manually on [Email Search page](https://cp.unione.io/en/user/email) in control
        # panel (but only a limited number of unsubscribed email per day can be removed).
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#unsubscribed-set
        # @param request [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedSetRequest, Hash]
        # @return [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedSetResponse]
        # @raise [::UniOne::Client::ApiError]
        def unsubscribed_set(request)
          ::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedSetResponse.from_h(@client.call('/unsubscribed/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Checks if an email is unsubscribed.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#unsubscribed-check
        # @param request [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedCheckRequest, Hash]
        # @return [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedCheckResponse]
        # @raise [::UniOne::Client::ApiError]
        def unsubscribed_check(request)
          ::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedCheckResponse.from_h(@client.call('/unsubscribed/check.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Returns a list of all unsubscribed emails since provided date.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#unsubscribed-list
        # @param request [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedListRequest, Hash]
        # @return [::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedListResponse]
        # @raise [::UniOne::Client::ApiError]
        def unsubscribed_list(request)
          ::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedListResponse.from_h(@client.call('/unsubscribed/list.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
