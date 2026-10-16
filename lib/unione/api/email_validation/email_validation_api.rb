# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module EmailValidation
      # Email validation methods. As a result of the check, you’ll get detailed information on email
      # validity. It will help eliminate nonexistent emails, decrease the number of complaints, clean up the
      # subscribers list and eventually enhance your sender reputation score. For example, you may add
      # validation to a subscription form on your site to let users know they’ve just entered an invalid
      # address.
      class EmailValidationApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # A maximum of two concurrent requests are allowed; if you send more requests, an error will be
        # returned. Since the verification process should be completed promptly, we've set a time limit on
        # email check. If we encounter a slow email server that does not respond in 5 seconds, you may get an
        # “unknown” status.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#email-validation-single
        # @param request [::UniOne::Api::EmailValidation::Model::EmailValidationSingleRequest, Hash]
        # @return [::UniOne::Api::EmailValidation::Model::EmailValidationSingleResponse]
        # @raise [::UniOne::Client::ApiError]
        def single(request)
          ::UniOne::Api::EmailValidation::Model::EmailValidationSingleResponse.from_h(@client.call('/email-validation/single.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
