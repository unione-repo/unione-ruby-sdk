# frozen_string_literal: true

module UniOne
  module Api
    module Template
      module Model
        # TemplateListRequest
        class TemplateListRequest
          # Limits the number of templates returned, default is 50.
          # Default: `50`.
          # @return [Integer, nil]
          attr_accessor :limit

          # Index of the first template in the list, starting with 0.
          # Default: `0`.
          # @return [Integer, nil]
          attr_accessor :offset

          def initialize(
            limit: nil,
            offset: nil
          )
            @limit = limit
            @offset = offset
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              limit: data['limit'],
              offset: data['offset']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
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
