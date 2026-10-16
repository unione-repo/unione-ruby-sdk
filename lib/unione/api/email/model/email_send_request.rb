# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # EmailSendRequest
        class EmailSendRequest
          # Object containing all message properties.
          # @return [MessageObject, nil]
          attr_accessor :message

          def initialize(
            message:
          )
            @message = message
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              message: ::UniOne::Client::Decode.model(::UniOne::Api::Email::Model::MessageObject, data['message'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'message' => @message.nil? ? nil : @message.to_h,
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
