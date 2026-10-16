# frozen_string_literal: true

module UniOne
  module Api
    module EventDump
      module Model
        # EventDumpCreateRequest
        class EventDumpCreateRequest
          # Date and time in YYYY-MM-DD hh:mm:ss format, specifying period start time. Data is stored for up to
          # 32 days, depending on your tariff.
          # @return [String, nil]
          attr_accessor :start_time

          # Date and time in YYYY-MM-DD hh:mm:ss format, specifying period end time (non-inclusive).
          # @return [String, nil]
          attr_accessor :end_time

          # Maximum number of events returned (default is 50). If this value is over 100 000, several files will
          # be created, each having 100 000 events maximum.
          # @return [Integer, nil]
          attr_accessor :limit

          # For accounts with projects enabled, the value all_projects=true allows to fetch data for all
          # existing projects.
          # Default: `False`.
          # @return [Boolean, nil]
          attr_accessor :all_projects

          # An object with the properties of the event dump filter.
          # @return [FilterObject, nil]
          attr_accessor :filter

          # An array of strings containing the names of columns you need in your report, in your preferred
          # order. If the 'dump_fields' array is missing or empty, a default field list and order will be
          # applied. Allowed values, in their default order, are - 'project_id', 'event_time', 'job_id',
          # 'from_email', 'email', 'status', 'delivery_status', 'metadata', 'destination_response',
          # 'user_agent', 'url', 'ip', 'tags'. For maximum security, the 'subject' field is not included by
          # default, but you can add it by explicitly including in the 'dump_fields' array.
          # @return [Array<String>, nil]
          attr_accessor :dump_fields

          # Allows you to obtain aggregated statistics for a given time period. The two allowed values are:
          #
          # - __day_status__ - fetch aggregated statistics (the filter value must be missing or empty, as filters are not allowed with this option);
          # - __an empty string__ - used by default, event_dump/create works as if the aggregate parameter is omitted.
          # @return [String, nil]
          attr_accessor :aggregate

          # Field delimiter, can be set to either  ',' or ';', defaults to  ','.
          # @return [String, nil]
          attr_accessor :delimiter

          # File format, either “csv” (default) or “csv_gzip”.
          # Default: `csv`.
          # @return [String, nil]
          attr_accessor :format

          def initialize(
            start_time:,
            end_time: nil,
            limit: nil,
            all_projects: nil,
            filter: nil,
            dump_fields: nil,
            aggregate: nil,
            delimiter: nil,
            format: nil
          )
            @start_time = start_time
            @end_time = end_time
            @limit = limit
            @all_projects = all_projects
            @filter = filter
            @dump_fields = dump_fields
            @aggregate = aggregate
            @delimiter = delimiter
            @format = format
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              start_time: data['start_time'],
              end_time: data['end_time'],
              limit: data['limit'],
              all_projects: data['all_projects'],
              filter: ::UniOne::Client::Decode.model(::UniOne::Api::EventDump::Model::FilterObject, data['filter']),
              dump_fields: ::UniOne::Client::Decode.list(data['dump_fields']),
              aggregate: data['aggregate'],
              delimiter: data['delimiter'],
              format: data['format']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'start_time' => @start_time,
              'end_time' => @end_time,
              'limit' => @limit,
              'all_projects' => @all_projects,
              'filter' => @filter.nil? ? nil : @filter.to_h,
              'dump_fields' => @dump_fields,
              'aggregate' => @aggregate,
              'delimiter' => @delimiter,
              'format' => @format,
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
