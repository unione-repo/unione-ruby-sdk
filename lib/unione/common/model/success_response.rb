# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # SuccessResponse
      class SuccessResponse
        # "success" string
        # Allowed values: `success`.
        # @return [String, nil]
        attr_accessor :status

        def initialize(
          status: nil
        )
          @status = status
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            status: data['status']
          )
        end

        # JSON-ready hash, nil fields are omitted.
        def to_h
          {
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
