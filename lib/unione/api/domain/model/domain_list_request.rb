# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # DomainListRequest
        class DomainListRequest
          # Optional domain name if you want to get the status of single domain only.
          # @return [String, nil]
          attr_accessor :domain

          # Limits the number of domains returned. Default is 50.
          # Default: `50`.
          # @return [Integer, nil]
          attr_accessor :limit

          # Index of the first domain in the list, starting with 0.
          # Default: `0`.
          # @return [Integer, nil]
          attr_accessor :offset

          def initialize(
            domain: nil,
            limit: nil,
            offset: nil
          )
            @domain = domain
            @limit = limit
            @offset = offset
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              domain: data['domain'],
              limit: data['limit'],
              offset: data['offset']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'domain' => @domain,
              'limit' => @limit,
              'offset' => @offset,
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
