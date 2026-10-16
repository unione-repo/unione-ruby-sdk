# frozen_string_literal: true

module UniOne
  module Api
    module System
      module Model
        # SystemPingResponse
        class SystemPingResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Unique user identifier.
          # @return [Integer, nil]
          attr_accessor :user_id

          def initialize(
            status: nil,
            user_id: nil
          )
            @status = status
            @user_id = user_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              user_id: data['user_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'user_id' => @user_id,
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
