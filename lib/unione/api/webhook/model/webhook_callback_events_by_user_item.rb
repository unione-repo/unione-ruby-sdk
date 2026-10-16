# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookCallbackEventsByUserItem
        class WebhookCallbackEventsByUserItem
          # Unique user identifier.
          # @return [Integer, nil]
          attr_accessor :user_id

          # Project identifier, present only if webhook was registered for the project using project API key.
          # @return [String, nil]
          attr_accessor :project_id

          # Project name, present only if webhook was registered for the project using project API key.
          # @return [String, nil]
          attr_accessor :project_name

          # Array of events reported by webhook.
          # @return [Array<WebhookCallbackEventsByUserItemEventsItem>, nil]
          attr_accessor :events

          def initialize(
            user_id: nil,
            project_id: nil,
            project_name: nil,
            events: nil
          )
            @user_id = user_id
            @project_id = project_id
            @project_name = project_name
            @events = events
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              user_id: data['user_id'],
              project_id: data['project_id'],
              project_name: data['project_name'],
              events: ::UniOne::Client::Decode.list(data['events']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookCallbackEventsByUserItemEventsItem, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'user_id' => @user_id,
              'project_id' => @project_id,
              'project_name' => @project_name,
              'events' => @events.nil? ? nil : @events.map { |item0| item0.to_h },
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
