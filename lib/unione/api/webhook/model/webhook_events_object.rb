# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Object containing events to notify of.
        class WebhookEventsObject
          # If present then spam block events will be reported. Should contain single array element with "*"
          # string.
          # @return [Array<String>, nil]
          attr_accessor :spam_block

          # If present then email status change events will be reported. Contains names of statuses to notify
          # of.
          # @return [Array<EmailStatus>, nil]
          attr_accessor :email_status

          def initialize(
            spam_block: nil,
            email_status: nil
          )
            @spam_block = spam_block
            @email_status = email_status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              spam_block: ::UniOne::Client::Decode.list(data['spam_block']),
              email_status: ::UniOne::Client::Decode.list(data['email_status'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'spam_block' => @spam_block,
              'email_status' => @email_status,
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
