# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # Object describing DKIM record value and status.
        class DomainListResponseDomainsItemDkim
          # DKIM signature for the domain. This property contains only the key part, you should prepend it with
          # "k=rsa, p=" part for the record to be valid (see
          # [domain/get-dns-records](https://docs.unione.io/en/web-api-ref#domain-get-dns-records)).
          # @return [String, nil]
          attr_accessor :key

          # Only domains with "active" DKIM record are allowed as sender domains.
          # @return [DkimStatus, nil]
          attr_accessor :status

          def initialize(
            key: nil,
            status: nil
          )
            @key = key
            @status = status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              key: data['key'],
              status: data['status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'key' => @key,
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
