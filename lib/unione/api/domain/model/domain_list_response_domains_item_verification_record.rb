# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # Object describing verification record value and status.
        class DomainListResponseDomainsItemVerificationRecord
          # Record to be added "as is" to verify ownership of this domain.
          # @return [String, nil]
          attr_accessor :value

          # Only domains with "confirmed" verification record are allowed as sender domains.
          # @return [VerificationRecordStatus, nil]
          attr_accessor :status

          def initialize(
            value: nil,
            status: nil
          )
            @value = value
            @status = status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              value: data['value'],
              status: data['status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'value' => @value,
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
