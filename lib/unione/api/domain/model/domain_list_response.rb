# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # DomainListResponse
        class DomainListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Array of objects describing domains.
          # @return [Array<DomainListResponseDomainsItem>, nil]
          attr_accessor :domains

          def initialize(
            status: nil,
            domains: nil
          )
            @status = status
            @domains = domains
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              domains: ::UniOne::Client::Decode.list(data['domains']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Domain::Model::DomainListResponseDomainsItem, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'domains' => @domains.nil? ? nil : @domains.map { |item0| item0.to_h },
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
