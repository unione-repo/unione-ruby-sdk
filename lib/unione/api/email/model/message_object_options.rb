# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # Additional message options.
        class MessageObjectOptions
          # Date and time in "YYYY-MM-DD hh:mm:ss" format in the UTC timezone. Allows schedule sending up to 24
          # hours in advance.
          # @return [String, nil]
          attr_accessor :send_at

          # Custom unsubscribe link. Read more [here](https://docs.unione.io/en/unsubscribe-link).
          # @return [String, nil]
          attr_accessor :unsubscribe_url

          # Backend-domain identifier to send message with. If custom_backend_id is not set, default one for
          # your account/project will be used. You can pay for one or more dedicated IPs and use this option.
          # @return [Integer, nil]
          attr_accessor :custom_backend_id

          # SMTP pool identifier to send message with. Usually you don't need to pass this parameter because
          # correct smtp_pool_id is selected automatically based on the default one for your account/project or
          # according to custom_backend_id parameter.
          # @return [String, nil]
          attr_accessor :smtp_pool_id

          def initialize(
            send_at: nil,
            unsubscribe_url: nil,
            custom_backend_id: nil,
            smtp_pool_id: nil
          )
            @send_at = send_at
            @unsubscribe_url = unsubscribe_url
            @custom_backend_id = custom_backend_id
            @smtp_pool_id = smtp_pool_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              send_at: data['send_at'],
              unsubscribe_url: data['unsubscribe_url'],
              custom_backend_id: data['custom_backend_id'],
              smtp_pool_id: data['smtp_pool_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'send_at' => @send_at,
              'unsubscribe_url' => @unsubscribe_url,
              'custom_backend_id' => @custom_backend_id,
              'smtp_pool_id' => @smtp_pool_id,
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
