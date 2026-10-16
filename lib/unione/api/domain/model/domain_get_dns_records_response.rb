# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # DomainGetDnsRecordsResponse
        class DomainGetDnsRecordsResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Domain to get DNS records for.
          # @return [String, nil]
          attr_accessor :domain

          # Record to be added "as is" to verify ownership of this domain.
          # @return [String, nil]
          attr_accessor :verification_record

          # DKIM signature for the domain. This property contains only the key part, you should prepend it with
          # "v=DKIM1; k=rsa; p=" for the TXT record to be valid.
          # @return [String, nil]
          attr_accessor :dkim

          # Target of the CNAME record for the "_dmarc" host of the domain.
          # @return [String, nil]
          attr_accessor :dmarc

          def initialize(
            status: nil,
            domain: nil,
            verification_record: nil,
            dkim: nil,
            dmarc: nil
          )
            @status = status
            @domain = domain
            @verification_record = verification_record
            @dkim = dkim
            @dmarc = dmarc
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              domain: data['domain'],
              verification_record: data['verification-record'],
              dkim: data['dkim'],
              dmarc: data['dmarc']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'domain' => @domain,
              'verification-record' => @verification_record,
              'dkim' => @dkim,
              'dmarc' => @dmarc,
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
