# frozen_string_literal: true

module UniOne
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedListResponse
        class ObsoleteUnsubscribedListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Array of object describing unsubscribed emails.
          # @return [Array<ObsoleteUnsubscribedListResponseUnsubscribedItem>, nil]
          attr_accessor :unsubscribed

          def initialize(
            status: nil,
            unsubscribed: nil
          )
            @status = status
            @unsubscribed = unsubscribed
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              unsubscribed: ::UniOne::Client::Decode.list(data['unsubscribed']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Obsolete::Model::ObsoleteUnsubscribedListResponseUnsubscribedItem, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'unsubscribed' => @unsubscribed.nil? ? nil : @unsubscribed.map { |item0| item0.to_h },
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
