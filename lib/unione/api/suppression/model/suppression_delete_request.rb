# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # SuppressionDeleteRequest
        class SuppressionDeleteRequest
          # An email to delete from suppression list.
          # @return [String, nil]
          attr_accessor :email

          def initialize(
            email:
          )
            @email = email
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
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
