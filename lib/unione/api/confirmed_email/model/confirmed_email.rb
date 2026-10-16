# frozen_string_literal: true

module UniOne
  module Api
    module ConfirmedEmail
      module Model
        # ConfirmedEmail
        class ConfirmedEmail
          # @return [String, nil]
          attr_accessor :email

          # Confirmation status of the email address.
          # @return [VerificationRecordStatus, nil]
          attr_accessor :status

          def initialize(
            email: nil,
            status: nil
          )
            @email = email
            @status = status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              status: data['status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'status' => @status,
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
