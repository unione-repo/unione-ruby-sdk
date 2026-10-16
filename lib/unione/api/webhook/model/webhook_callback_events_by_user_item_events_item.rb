# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookCallbackEventsByUserItemEventsItem
        class WebhookCallbackEventsByUserItemEventsItem
          # Type of event data contained in event_data field, either "transactional_email_status" or
          # "transactional_spam_block".
          # @return [EventName, nil]
          attr_accessor :event_name

          # Object with different event properties depending on "event_name". Below you can see all the
          # properties, "transactional_email_status"-related first and then "transactional_spam_block"-related.
          # @return [WebhookCallbackEventsByUserItemEventsItemEventData, nil]
          attr_accessor :event_data

          def initialize(
            event_name: nil,
            event_data: nil
          )
            @event_name = event_name
            @event_data = event_data
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              event_name: data['event_name'],
              event_data: ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookCallbackEventsByUserItemEventsItemEventData, data['event_data'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'event_name' => @event_name,
              'event_data' => @event_data.nil? ? nil : @event_data.to_h,
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
