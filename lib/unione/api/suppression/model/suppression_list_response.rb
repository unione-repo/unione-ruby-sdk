# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # SuppressionListResponse
        class SuppressionListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Array of suppression objects.
          # @return [Array<SuppressionListObject>, nil]
          attr_accessor :suppressions

          # The parameter indicates from which position the selection is to be started. Must be empty or omitted
          # for the first data chunk. In order to get subsequent chunks, you must set the "cursor" parameter in
          # your request, using the value received in response to the previous request.
          # @return [String, nil]
          attr_accessor :cursor

          def initialize(
            status: nil,
            suppressions: nil,
            cursor: nil
          )
            @status = status
            @suppressions = suppressions
            @cursor = cursor
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              suppressions: ::UniOne::Client::Decode.list(data['suppressions']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Suppression::Model::SuppressionListObject, item0) },
              cursor: data['cursor']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'suppressions' => @suppressions.nil? ? nil : @suppressions.map { |item0| item0.to_h },
              'cursor' => @cursor,
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
