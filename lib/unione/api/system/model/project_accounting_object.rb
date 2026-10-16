# frozen_string_literal: true

module UniOne
  module Api
    module System
      module Model
        # Object with email counter properties. Present only if the API key used for request is the user API
        # key.
        class ProjectAccountingObject
          # Project's email counter value. It increases on every email sent.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Allows you to limit the number of emails sent by the project. The sending stops when the limit is
          # reached. Any non-negative 64-bit integer is acceptable. 0 means no limit.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # 'default' - the counter resets to zero automatically at the beginning of each accounting period.
          # 'permanent' - the counter never resets automatically.
          # Default: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          def initialize(
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil
          )
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
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
