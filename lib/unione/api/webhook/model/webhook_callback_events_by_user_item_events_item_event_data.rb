# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Object with different event properties depending on "event_name". Below you can see all the
        # properties, "transactional_email_status"-related first and then "transactional_spam_block"-related.
        class WebhookCallbackEventsByUserItemEventsItemEventData
          # Job identifier returned earlier by [email/send](https://docs.unione.io/en/web-api-ref#email-send)
          # method. Property exists only if event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :job_id

          # Metadata passed in [email/send](https://docs.unione.io/en/web-api-ref#email-send) method in
          # recipients.metadata or global_metadata properties. This property exists only if
          # event_name="transactional_email_status".
          # @return [Hash{String => String}, nil]
          attr_accessor :metadata

          # Recipient's email. This property exists only if event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :email

          # Email delivery status. This property exists only if event_name="transactional_email_status".
          # Possible values are:
          #
          # __accepted__ — the message has been accepted, but not sent yet.
          # __sent__ — the message has been sent, but not delivered yet.
          # __delivered__ — the message has been delivered. It can be changed to “opened”, “clicked”,
          # “unsubscribed”, “subscribed” or “spam”.
          # __opened__ — the message has been delivered and read. It can be changed to “clicked”,
          # “unsubscribed”, “subscribed” or “spam”.
          # __clicked__ — the message has been delivered, read, and at least one of the links in email has been
          # clicked. It can be changed to “unsubscribed”, “subscribed” or “spam”.
          # __unsubscribed__ — the message has been delivered to the recipient and read, but then the recipient
          # unsubscribed. It can be changed to “subscribed”.
          # __subscribed__ — the message has been delivered to the recipient and read, but then the recipient
          # unsubscribed and subscribed again. It can be changed to “unsubscribed”.
          # __soft_bounced__ — temporary delivery failure. UniOne will try to deliver the message during 48
          # hours. In case of success the status changes to “delivered”, in case of failure to deliver during 48
          # hours message status changes to “hard_bounced”.
          # __hard_bounced__ — failed to deliver the message, there will be no delivery attempts. It's a final
          # status. There are a lot of possible reasons, you can use SMTP response from
          # delivery_info.destination_response field or UniOne internal reason classification from
          # delivery_info.delivery_status field to analyze the reason.
          # __spam__ — the message has been delivered, but it was reported as spam by the recipient. UniOne can
          # receive and process the spam complaint from several domains, including msn.com, outlook.com,
          # hotmail.com, live.com, ukr.net, yahoo.com, aol.com using
          # [FBL](https://en.wikipedia.org/wiki/Feedback_loop_(email)).
          # @return [EmailStatus, nil]
          attr_accessor :status

          # Event date & time in UTC time zone in "YYYY-MM-DD hh:mm:ss" format. This property exists only if
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :event_time

          # URL for "opened" and "clicked" statuses. This property exists only if
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :url

          # Object with detailed delivery info.Event date & time in UTC time zone in "YYYY-MM-DD hh:mm:ss"
          # format. This property exists only if webhook has delivery_info proeprty set to 1 and
          # event_name="transactional_email_status".
          # @return [WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo, nil]
          attr_accessor :delivery_info

          # Spam block date & time in UTC time zone in "YYYY-MM-DD hh:mm:ss" format. This property exists only
          # if event_name="transactional_spam_block".
          # @return [String, nil]
          attr_accessor :block_time

          # Spam block type, either single or multiple sending SMTP. For single sending SMTP block in common
          # pool UniOne retries several other SMTPs. This property exists only if
          # event_name="transactional_spam_block".
          # @return [BlockType, nil]
          attr_accessor :block_type

          # Domain that blocked sending. This property exists only if event_name="transactional_spam_block".
          # @return [String, nil]
          attr_accessor :domain

          # Number of sending SMTPs blocked. This property exists only if event_name="transactional_spam_block".
          # @return [Integer, nil]
          attr_accessor :smtp_blocks_count

          # Whether it's a block or unblock event. This property exists only if
          # event_name="transactional_spam_block".
          # @return [DomainStatus, nil]
          attr_accessor :domain_status

          def initialize(
            job_id: nil,
            metadata: nil,
            email: nil,
            status: nil,
            event_time: nil,
            url: nil,
            delivery_info: nil,
            block_time: nil,
            block_type: nil,
            domain: nil,
            smtp_blocks_count: nil,
            domain_status: nil
          )
            @job_id = job_id
            @metadata = metadata
            @email = email
            @status = status
            @event_time = event_time
            @url = url
            @delivery_info = delivery_info
            @block_time = block_time
            @block_type = block_type
            @domain = domain
            @smtp_blocks_count = smtp_blocks_count
            @domain_status = domain_status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              job_id: data['job_id'],
              metadata: ::UniOne::Client::Decode.map(data['metadata']),
              email: data['email'],
              status: data['status'],
              event_time: data['event_time'],
              url: data['url'],
              delivery_info: ::UniOne::Client::Decode.model(::UniOne::Api::Webhook::Model::WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo, data['delivery_info']),
              block_time: data['block_time'],
              block_type: data['block_type'],
              domain: data['domain'],
              smtp_blocks_count: data['SMTP_blocks_count'],
              domain_status: data['domain_status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'job_id' => @job_id,
              'metadata' => @metadata,
              'email' => @email,
              'status' => @status,
              'event_time' => @event_time,
              'url' => @url,
              'delivery_info' => @delivery_info.nil? ? nil : @delivery_info.to_h,
              'block_time' => @block_time,
              'block_type' => @block_type,
              'domain' => @domain,
              'SMTP_blocks_count' => @smtp_blocks_count,
              'domain_status' => @domain_status,
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
