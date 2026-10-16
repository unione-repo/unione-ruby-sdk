# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Webhook callback format description.
        class WebhookCallback
          # MD5-hash of the message body, in which the value "auth" is replaced by api key of the user/project;
          # with this field the recipient of the notification can both authenticate and verify the notification
          # integrity
          # @return [String, nil]
          attr_accessor :auth

          # Array with only one element, containing events of a user/project.
          # @return [Array<WebhookCallbackEventsByUserItem>, nil]
          attr_accessor :events_by_user

          def initialize(
            auth: nil,
            events_by_user: nil
          )
            @auth = auth
            @events_by_user = events_by_user
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              auth: data['auth'],
              events_by_user: ::UniOne::Client::Decode.list(data['events_by_user']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookCallbackEventsByUserItem, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'auth' => @auth,
              'events_by_user' => @events_by_user.nil? ? nil : @events_by_user.map { |item0| item0.to_h },
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
