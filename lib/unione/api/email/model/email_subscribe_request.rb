# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # EmailSubscribeRequest
        class EmailSubscribeRequest
          # Sender’s email on a confirmed domain. (Field alias "email_address_from" is supported, too).
          # @return [String, nil]
          attr_accessor :from_email

          # Sender’s name. (Field alias "name_from" is supported, too).
          # @return [String, nil]
          attr_accessor :from_name

          # Recipient’s email. (Field alias "email_address_to" is supported, too).
          # @return [String, nil]
          attr_accessor :to_email

          def initialize(
            from_email:,
            from_name:,
            to_email:
          )
            @from_email = from_email
            @from_name = from_name
            @to_email = to_email
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              from_email: data['from_email'],
              from_name: data['from_name'],
              to_email: data['to_email']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'from_email' => @from_email,
              'from_name' => @from_name,
              'to_email' => @to_email,
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
