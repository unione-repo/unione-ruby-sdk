# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookGetResponse
        class WebhookGetResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Object with all the webhook properties.
          # @return [WebhookObject, nil]
          attr_accessor :object

          def initialize(
            status: nil,
            object: nil
          )
            @status = status
            @object = object
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              object: ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookObject, data['object'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'object' => @object.nil? ? nil : @object.to_h,
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
