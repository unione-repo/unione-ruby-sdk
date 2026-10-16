# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # WebhookSetRequest
        class WebhookSetRequest
          # URL that will receive the notification when an event occurs. The URL should be unique for a user or
          # a project. Only ASCII characters are supported for now in URL, please convert to
          # [Punycode](https://en.wikipedia.org/wiki/Punycode) if you need to use non-ASCII characters.
          # @return [String, nil]
          attr_accessor :url

          # Webhook status, "active" by default. "disabled" means that webhook has been disabled by the user,
          # "stopped" means that webhook has been stopped by the system after 24h of failed calls (with minimum
          # of 10 distinct events).
          # Default: `active`.
          # @return [WebhookStatus, nil]
          attr_accessor :status

          # Notification format. "json_post"(default) or "json_post_gzip".
          # Default: `json_post`.
          # @return [WebhookEventFormat, nil]
          attr_accessor :event_format

          # Shall detailed delivery info be returned(1) or not(0). When it's 1, the information about SMTP
          # response and internal delivery status is returned for "hard_bounced" and "soft_bounced" email
          # statuses; the user agent, recipient IP address, detected geo fields, device info detected from the
          # user agent (device type and brand, OS name, browser or email client name) and traffic_type (human,
          # machine, protected or unknown) are returned for "opened" and "clicked" statuses; URL is returned for
          # "clicked" status. For "delivered", "soft_bounced" and "hard_bounced" statuses UniOne may also return
          # sender_ip, the IP address of the SMTP server that sent the message, if available.
          # Allowed values: `0`, `1`.
          # Default: `0`.
          # @return [Integer, nil]
          attr_accessor :delivery_info

          # 0=several event notifications can be reported in single webhook call, 1=only single event can be
          # reported in one call (not recommended).
          # Allowed values: `0`, `1`.
          # Default: `0`.
          # @return [Integer, nil]
          attr_accessor :single_event

          # Maximum quantity of permitted parallel queries to your server. The more your server can handle - the
          # better.
          # Default: `10`.
          # @return [Integer, nil]
          attr_accessor :max_parallel

          # Object containing events to notify of.
          # @return [WebhookEventsObject, nil]
          attr_accessor :events

          def initialize(
            url:,
            status: nil,
            event_format: nil,
            delivery_info: nil,
            single_event: nil,
            max_parallel: nil,
            events: nil
          )
            @url = url
            @status = status
            @event_format = event_format
            @delivery_info = delivery_info
            @single_event = single_event
            @max_parallel = max_parallel
            @events = events
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              url: data['url'],
              status: data['status'],
              event_format: data['event_format'],
              delivery_info: data['delivery_info'],
              single_event: data['single_event'],
              max_parallel: data['max_parallel'],
              events: ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookEventsObject, data['events'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'url' => @url,
              'status' => @status,
              'event_format' => @event_format,
              'delivery_info' => @delivery_info,
              'single_event' => @single_event,
              'max_parallel' => @max_parallel,
              'events' => @events.nil? ? nil : @events.to_h,
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
