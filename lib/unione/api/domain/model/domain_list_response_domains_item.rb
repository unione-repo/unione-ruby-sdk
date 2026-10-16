# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # DomainListResponseDomainsItem
        class DomainListResponseDomainsItem
          # Domain name.
          # @return [String, nil]
          attr_accessor :domain

          # Object describing verification record value and status.
          # @return [DomainListResponseDomainsItemVerificationRecord, nil]
          attr_accessor :verification_record

          # Object describing DKIM record value and status.
          # @return [DomainListResponseDomainsItemDkim, nil]
          attr_accessor :dkim

          def initialize(
            domain: nil,
            verification_record: nil,
            dkim: nil
          )
            @domain = domain
            @verification_record = verification_record
            @dkim = dkim
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              domain: data['domain'],
              verification_record: ::UniOne::Client::Decode.model(::UniOne::Api::Domain::Model::DomainListResponseDomainsItemVerificationRecord, data['verification-record']),
              dkim: ::UniOne::Client::Decode.model(::UniOne::Api::Domain::Model::DomainListResponseDomainsItemDkim, data['dkim'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'domain' => @domain,
              'verification-record' => @verification_record.nil? ? nil : @verification_record.to_h,
              'dkim' => @dkim.nil? ? nil : @dkim.to_h,
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
