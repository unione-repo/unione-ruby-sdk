# frozen_string_literal: true

require 'json'

module UniOne
  module Api
    module EventDump
      # These methods are used to obtain a list of events for a given period of time. The data is stored for
      # up to 45 days, depending on your tariff, i. e. you may fetch all event data starting from 00:00:00
      # 31 days ago and up to current time. For custom tarifs with big sending volumes event dumps are
      # available only for the last 7 days.
      class EventDumpApi
        # @param client [::UniOne::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # This asynchronous method initiates the preparation of data dump in CSV format. The number of dump
        # files created or stored is limited to 10; to order more files, you have to delete one of the
        # previous ones or wait until they will be deleted automatically. A newly created dump file is kept
        # for 8 hours. If the request period is more than a day or there are too many events then several
        # files will be generated and each file will contain no more than 100,000 events. File contains
        # columns with the following information - 'event_time', 'job_id', 'from_email', 'email', 'status',
        # 'delivery_status', 'metadata', 'destination_response', 'user_agent', 'url', 'ip', 'tags' and
        # 'project_id' (for accounts with projects enabled). You can change the fields and include 'subject'
        # field using 'dump_fileds' parameter.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#event-dump-create
        # @param request [::UniOne::Api::EventDump::Model::EventDumpCreateRequest, Hash]
        # @return [::UniOne::Api::EventDump::Model::EventDumpCreateResponse]
        # @raise [::UniOne::Client::ApiError]
        def create(request)
          ::UniOne::Api::EventDump::Model::EventDumpCreateResponse.from_h(@client.call('/event-dump/create.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Returns dump properties for a given identifier
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#event-dump-get
        # @param request [::UniOne::Api::EventDump::Model::EventDumpGetRequest, Hash]
        # @return [::UniOne::Api::EventDump::Model::EventDumpGetResponse]
        # @raise [::UniOne::Client::ApiError]
        def get(request)
          ::UniOne::Api::EventDump::Model::EventDumpGetResponse.from_h(@client.call('/event-dump/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # This method does not require any parameters; returns the full list of existing dumps.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#event-dump-list
        # @return [::UniOne::Api::EventDump::Model::EventDumpListResponse]
        # @raise [::UniOne::Client::ApiError]
        def list
          ::UniOne::Api::EventDump::Model::EventDumpListResponse.from_h(@client.call('/event-dump/list.json'))
        end

        # Removes dump from queue or storage.
        #
        # Documentation: https://docs.unione.io/en/web-api-ref#event-dump-delete
        # @param request [::UniOne::Api::EventDump::Model::EventDumpDeleteRequest, Hash]
        # @return [::UniOne::Common::Model::SuccessResponse]
        # @raise [::UniOne::Client::ApiError]
        def delete(request)
          ::UniOne::Common::Model::SuccessResponse.from_h(@client.call('/event-dump/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
