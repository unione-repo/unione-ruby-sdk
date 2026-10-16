# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # DomainDeleteResponse
        class DomainDeleteResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Domain deleted
          # @return [String, nil]
          attr_accessor :message

          def initialize(
            status: nil,
            message: nil
          )
            @status = status
            @message = message
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              message: data['message']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
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
