# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # SuppressionGetResponse
        class SuppressionGetResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # The email for which suppression details were requested.
          # @return [String, nil]
          attr_accessor :email

          # Array of suppression objects.
          # @return [Array<SuppressionGetObject>, nil]
          attr_accessor :suppressions

          def initialize(
            status: nil,
            email: nil,
            suppressions: nil
          )
            @status = status
            @email = email
            @suppressions = suppressions
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              email: data['email'],
              suppressions: ::UniOne::Client::Decode.list(data['suppressions']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Suppression::Model::SuppressionGetObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'email' => @email,
              'suppressions' => @suppressions.nil? ? nil : @suppressions.map { |item0| item0.to_h },
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
