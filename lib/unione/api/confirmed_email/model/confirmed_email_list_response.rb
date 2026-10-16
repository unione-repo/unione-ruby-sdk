# frozen_string_literal: true

module UniOne
  module Api
    module ConfirmedEmail
      module Model
        # ConfirmedEmailListResponse
        class ConfirmedEmailListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # @return [Array<ConfirmedEmail>, nil]
          attr_accessor :confirmed_emails

          def initialize(
            status: nil,
            confirmed_emails: nil
          )
            @status = status
            @confirmed_emails = confirmed_emails
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              confirmed_emails: ::UniOne::Client::Decode.list(data['confirmed_emails']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::ConfirmedEmail::Model::ConfirmedEmail, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'confirmed_emails' => @confirmed_emails.nil? ? nil : @confirmed_emails.map { |item0| item0.to_h },
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
