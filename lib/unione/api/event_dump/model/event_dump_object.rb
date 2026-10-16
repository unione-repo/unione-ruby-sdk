# frozen_string_literal: true

module UniOne
  module Api
    module EventDump
      module Model
        # An object with the properties of the event dump.
        class EventDumpObject
          # Dump ID received by the method
          # [event-dump/create](https://docs.unione.io/en/web-api-ref#event-dump-create).
          # @return [String, nil]
          attr_accessor :dump_id

          # Task status, possible values are:
          #
          # - __queued__ - the task is in the queue, processing is not started yet;
          # - __in_process__ - the request is being processed;
          # - __ready__ - the task is finished, dump file is ready for download;
          # - __failed__ -  processing failed due to an internal error.
          # @return [String, nil]
          attr_accessor :dump_status

          # An array of objects, each representing a file, ready for download. You may start downloading
          # everything listed in “files” even if "dump_status" is still "in_process". If there are no events,
          # according to the specified parameters, an empty array will be returned.
          # @return [Array<EventDumpFilesObject>, nil]
          attr_accessor :files

          def initialize(
            dump_id: nil,
            dump_status: nil,
            files: nil
          )
            @dump_id = dump_id
            @dump_status = dump_status
            @files = files
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              dump_id: data['dump_id'],
              dump_status: data['dump_status'],
              files: ::UniOne::Client::Decode.list(data['files']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::EventDump::Model::EventDumpFilesObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'dump_id' => @dump_id,
              'dump_status' => @dump_status,
              'files' => @files.nil? ? nil : @files.map { |item0| item0.to_h },
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
