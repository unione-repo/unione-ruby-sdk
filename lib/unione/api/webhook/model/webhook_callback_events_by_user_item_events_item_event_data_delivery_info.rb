# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Object with detailed delivery info.Event date & time in UTC time zone in "YYYY-MM-DD hh:mm:ss"
        # format. This property exists only if webhook has delivery_info proeprty set to 1 and
        # event_name="transactional_email_status".
        class WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo
          # UniOne internal detailed delivery status. Some possible values are:
          #
          # __err_user_unknown__ -- email address doesn't exist;
          # __err_user_inactive__ -- email address isn't used anymore;
          # __err_will_retry__ -- email was temporary rejected, delivery will be retried later;
          # __err_mailbox_discarded__ -- email address was active earlier, but now it's deleted;
          # __err_mailbox_full__ -- mailbox is full;
          # __err_spam_rejected__ -- email was rejected as a spam;
          # __err_blacklisted__ -- email was rejected because sender IP or sender domain is found in a black
          # list;
          # __err_too_large__ -- email size is over limit, according to recipient's server;
          # __err_unsubscribed__ -- email was unsubscribed;
          # __err_unreachable__ -- numerous delivery failures lead to mark this email address as permanently
          # unavailable;
          # __err_skip_letter__ -- sending has been canceled because the email address is temporarily
          # unavailable;
          # __err_domain_inactive__ -- the domain does not accept mail or does not exist;
          # __err_destination_misconfigured__ -- the domain does not accept mail due to incorrect settings on
          # the recipient’s side, and the server’s response contains information about a cause that can be fixed
          # (for example, an inoperative blacklist is used, etc.);
          # __err_delivery_failed__ -- delivery failed due to other reasons;
          # __err_spam_skipped__ -- sending has been canceled because the campaign has been blocked as a spam;
          # __err_lost__ -- the message was not sent due to inconsistency of its parts or it has been lost
          # because of the failure on our side. The sender needs to re-send the letter on his own, since the
          # original has not been saved;
          #
          # We reserve the right to change or add internal delivery statuses as we need, so the following list
          # is provided as an example only, without any description: ok_sent, ok_delivered, ok_read,
          # ok_link_visited, ok_unsubscribed, ok_resubscribed, ok_spam_folder, ok_fbl, not_sent,
          # skip_dup_unreachable, skip_dup_temp_unreachable, skip_dup_mailbox_full, err_spam_removed,
          # err_resend, err_unknown, err_retry_letter, err_src_invalid, err_dest_invalid, err_not_available,
          # err_internal, err_no_dns, err_no_smtp, err_giveup.
          # @return [String, nil]
          attr_accessor :delivery_status

          # SMTP response.
          # @return [String, nil]
          attr_accessor :destination_response

          # User agent of recipient. Present only if detected for "clicked" and "opened" statuses.
          # @return [String, nil]
          attr_accessor :user_agent

          # Recipient's device type, detected from the user agent. Present for "clicked" and "opened" statuses;
          # equals "unknown" if the device type couldn't be detected.
          # @return [DeviceType, nil]
          attr_accessor :device_type

          # Recipient's device brand, detected from the user agent. Present for "clicked" and "opened" statuses
          # if detected. For device_type "mobile" and "tablet" it's always present and equals "unknown" when the
          # brand couldn't be detected.
          # @return [String, nil]
          attr_accessor :device_brand

          # Name of the operating system of the recipient's device, detected from the user agent. Present for
          # "clicked" and "opened" statuses; equals "unknown" if the OS couldn't be detected.
          # @return [String, nil]
          attr_accessor :os_name

          # Name of the browser the email was opened in, detected from the user agent. Present for "clicked" and
          # "opened" statuses only if a browser was detected, so it never comes together with email_client_name.
          # @return [String, nil]
          attr_accessor :browser_name

          # Name of the email client application the email was opened in, detected from the user agent. Present
          # for "clicked" and "opened" statuses only if an email client was detected, so it never comes together
          # with browser_name.
          # @return [String, nil]
          attr_accessor :email_client_name

          # Traffic quality for "opened" and "clicked" statuses. "human" means a recognized browser or email
          # client without machine signs; "machine" means a bot, link scanner or security proxy; "protected"
          # means a mailbox/OS privacy proxy where a human action cannot be confirmed (Apple Mail Privacy
          # Protection / iCloud Private Relay, Gmail Image Proxy — Apple MPP is protected, not machine);
          # "unknown" means the user agent is missing, broken or not recognized.
          # @return [TrafficType, nil]
          attr_accessor :traffic_type

          # Recipient's IP address. Present only if detected for "clicked" and "opened" statuses.
          # @return [String, nil]
          attr_accessor :ip

          # ISO 3166-1 alpha-2 country code detected from recipient IP. Present for "clicked" and "opened"
          # statuses.
          # @return [String, nil]
          attr_accessor :country_code

          # Country detected from recipient IP. Present for "clicked" and "opened" statuses.
          # @return [String, nil]
          attr_accessor :country

          # City detected from recipient IP. Present for "clicked" and "opened" statuses.
          # @return [String, nil]
          attr_accessor :city

          # IP address of the SMTP server that sent the message. Present only for "delivered", "soft_bounced"
          # and "hard_bounced" statuses, if available.
          # @return [String, nil]
          attr_accessor :sender_ip

          def initialize(
            delivery_status: nil,
            destination_response: nil,
            user_agent: nil,
            device_type: nil,
            device_brand: nil,
            os_name: nil,
            browser_name: nil,
            email_client_name: nil,
            traffic_type: nil,
            ip: nil,
            country_code: nil,
            country: nil,
            city: nil,
            sender_ip: nil
          )
            @delivery_status = delivery_status
            @destination_response = destination_response
            @user_agent = user_agent
            @device_type = device_type
            @device_brand = device_brand
            @os_name = os_name
            @browser_name = browser_name
            @email_client_name = email_client_name
            @traffic_type = traffic_type
            @ip = ip
            @country_code = country_code
            @country = country
            @city = city
            @sender_ip = sender_ip
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              delivery_status: data['delivery_status'],
              destination_response: data['destination_response'],
              user_agent: data['user_agent'],
              device_type: data['device_type'],
              device_brand: data['device_brand'],
              os_name: data['os_name'],
              browser_name: data['browser_name'],
              email_client_name: data['email_client_name'],
              traffic_type: data['traffic_type'],
              ip: data['ip'],
              country_code: data['country_code'],
              country: data['country'],
              city: data['city'],
              sender_ip: data['sender_ip']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'delivery_status' => @delivery_status,
              'destination_response' => @destination_response,
              'user_agent' => @user_agent,
              'device_type' => @device_type,
              'device_brand' => @device_brand,
              'os_name' => @os_name,
              'browser_name' => @browser_name,
              'email_client_name' => @email_client_name,
              'traffic_type' => @traffic_type,
              'ip' => @ip,
              'country_code' => @country_code,
              'country' => @country,
              'city' => @city,
              'sender_ip' => @sender_ip,
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
