# frozen_string_literal: true

module UniOne
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedSetResponse
        class ObsoleteUnsubscribedSetResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # The unsubscribed email.
          # @return [String, nil]
          attr_accessor :address

          # Unsubscription process details:
          #
          # - "unsubscribed" if email has just been unsubscribed,
          # - "was inactive" if it was inactive due some reason,
          # - "was unsubscribed" if it already was unsubscribed before the call,
          # - "added and unsubscribed" if it's a new email without status history and it was added and then unsubscribed immediately.
          # @return [ObsoleteUnsubscribedSetMessage, nil]
          attr_accessor :message

          def initialize(
            status: nil,
            address: nil,
            message: nil
          )
            @status = status
            @address = address
            @message = message
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              address: data['address'],
              message: data['message']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'address' => @address,
              'message' => @message,
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
