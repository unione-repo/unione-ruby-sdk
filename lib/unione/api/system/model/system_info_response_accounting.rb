# frozen_string_literal: true

module UniOne
  module Api
    module System
      module Model
        # Object with accounting period properties. Present only if the API key used for request is the user
        # API key.
        class SystemInfoResponseAccounting
          # Date and time of accounting period start in UTC in "YYYY-MM-DD hh:mm:ss" format.
          # @return [String, nil]
          attr_accessor :period_start

          # Date and time of accounting period end in UTC in "YYYY-MM-DD hh:mm:ss" format.
          # @return [String, nil]
          attr_accessor :period_end

          # Number of emails included into accounting period.
          # @return [Integer, nil]
          attr_accessor :emails_included

          # Number of emails sent during accounting period. Can be bigger than emails_included in case of
          # overage.
          # @return [Integer, nil]
          attr_accessor :emails_sent

          def initialize(
            period_start: nil,
            period_end: nil,
            emails_included: nil,
            emails_sent: nil
          )
            @period_start = period_start
            @period_end = period_end
            @emails_included = emails_included
            @emails_sent = emails_sent
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              period_start: data['period_start'],
              period_end: data['period_end'],
              emails_included: data['emails_included'],
              emails_sent: data['emails_sent']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'period_start' => @period_start,
              'period_end' => @period_end,
              'emails_included' => @emails_included,
              'emails_sent' => @emails_sent,
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
