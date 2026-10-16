# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookListResponse
        class WebhookListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Array of webhooks objects.
          # @return [Array<WebhookObject>, nil]
          attr_accessor :objects

          def initialize(
            status: nil,
            objects: nil
          )
            @status = status
            @objects = objects
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              objects: ::UniOne::Client::Decode.list(data['objects']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'objects' => @objects.nil? ? nil : @objects.map { |item0| item0.to_h },
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
