# frozen_string_literal: true

module UniOne
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedListResponseUnsubscribedItem
        class ObsoleteUnsubscribedListResponseUnsubscribedItem
          # Unsubscribed email.
          # @return [String, nil]
          attr_accessor :address

          # Date and time when a recipient unsubscribed, in UTC timezone and "YYYY-MM-DD hh:mm:ss" format.
          # @return [String, nil]
          attr_accessor :unsubscribed_on

          def initialize(
            address: nil,
            unsubscribed_on: nil
          )
            @address = address
            @unsubscribed_on = unsubscribed_on
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              address: data['address'],
              unsubscribed_on: data['unsubscribed_on']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'address' => @address,
              'unsubscribed_on' => @unsubscribed_on,
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
