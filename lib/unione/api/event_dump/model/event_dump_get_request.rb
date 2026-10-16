# frozen_string_literal: true

module UniOne
  module Api
    module EventDump
      module Model
        # EventDumpGetRequest
        class EventDumpGetRequest
          # Dump identifier received by the method
          # [event-dump/create](https://docs.unione.io/en/web-api-ref#event-dump-create).
          # @return [String, nil]
          attr_accessor :dump_id

          def initialize(
            dump_id:
          )
            @dump_id = dump_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              dump_id: data['dump_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'dump_id' => @dump_id,
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
