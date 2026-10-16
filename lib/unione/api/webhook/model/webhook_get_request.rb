# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookGetRequest
        class WebhookGetRequest
          # Webhook URL.
          # @return [String, nil]
          attr_accessor :url

          def initialize(
            url:
          )
            @url = url
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              url: data['url']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'url' => @url,
            }.compact
          end

          def to_json(*args)
            to_h.to_json(*args)
          end
        end
      end
    end
  end
end
