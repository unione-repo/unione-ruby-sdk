# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # MessageObjectRecipientsItem
        class MessageObjectRecipientsItem
          # Recipient email
          # @return [String, nil]
          attr_accessor :email

          # Object to pass the substitutions(merge tags) for the recipient (e.g. recipient name, discount code,
          # password change link, etc. See [Template engines](https://docs.unione.io/en/template-engines)). The
          # substitutions can be used in the following parameters:
          #
          # - body.html
          # - body.plaintext
          # - body.amp
          # - subject
          # - from_name
          # - headers["List-Unsubscribe"]
          # - options.unsubscribe_url
          # A substitution name can consist from latin characters, numbers and "_" symbol, and should start with
          # the letter. There's a special substitution "to_name" which is used to put recipent's name like "Name
          # Surname" to include it to SMTP header "To" in the form "Name Surname <email@example.com>". The
          # "to_name" length is limited to 78 symbols.
          # @return [Hash{String => String}, nil]
          attr_accessor :substitutions

          # Object for passing the metadata, such as "key": "value". Max key quantity: 10. Max key length: 64
          # symbols. Max value length: 1024 symbols. The metadata is returned by
          # [webhook](https://docs.unione.io/en/web-api-ref#webhook) and
          # [event-dump](https://docs.unione.io/en/web-api-ref#event-dump) methods. If you pass strign up to 128
          # bit with "campaign_id" field name (name is configurable thru support), it will be considered as
          # campaign identifier in statistics.
          # @return [Hash{String => String}, nil]
          attr_accessor :metadata

          def initialize(
            email:,
            substitutions: nil,
            metadata: nil
          )
            @email = email
            @substitutions = substitutions
            @metadata = metadata
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              substitutions: ::UniOne::Client::Decode.map(data['substitutions']),
              metadata: ::UniOne::Client::Decode.map(data['metadata'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'substitutions' => @substitutions,
              'metadata' => @metadata,
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
