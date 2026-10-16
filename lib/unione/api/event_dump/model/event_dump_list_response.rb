# frozen_string_literal: true

module UniOne
  module Api
    module EventDump
      module Model
        # EventDumpListResponse
        class EventDumpListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # An array of objects describing event dumps. Each object is similar to 'event_dump' object returned
          # by the [event-dump/get](https://docs.unione.io/en/web-api-ref#event-dump-get) method.
          # @return [Array<EventDumpObject>, nil]
          attr_accessor :event_dumps

          def initialize(
            status: nil,
            event_dumps: nil
          )
            @status = status
            @event_dumps = event_dumps
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              event_dumps: ::UniOne::Client::Decode.list(data['event_dumps']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::EventDump::Model::EventDumpObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'event_dumps' => @event_dumps.nil? ? nil : @event_dumps.map { |item0| item0.to_h },
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
