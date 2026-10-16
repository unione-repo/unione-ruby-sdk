# frozen_string_literal: true

module UniOne
  module Api
    module EventDump
      module Model
        # An object with the properties of the event dump filter.
        class FilterObject
          # Job identifier returned earlier by [email/send](https://docs.unione.io/en/web-api-ref#email-send)
          # method.
          # @return [String, nil]
          attr_accessor :job_id

          # Email status. Possible values are:
          #
          # __accepted__ — the message has been accepted, but not sent yet.
          # __sent__ — the message has been sent, but not delivered yet.
          # __delivered__ — the message has been delivered.
          # __opened__ — the message has been delivered and read.
          # __clicked__ — the message has been delivered, read, and at least one of the links in email has been
          # clicked.
          # __unsubscribed__ — the message has been delivered to the recipient and read, but then the recipient
          # unsubscribed.
          # __subscribed__ — the message has been delivered to the recipient and read, but then the recipient
          # unsubscribed and subscribed again.
          # __soft_bounced__ — temporary delivery failure. UniOne will try to deliver the message during 48
          # hours.
          # __hard_bounced__ — failed to deliver the message, there will be no delivery attempts.
          # __spam__ — the message has been delivered, but it was reported as spam by the recipient.
          # @return [EmailStatus, nil]
          attr_accessor :status

          # UniOne internal detailed delivery status, you can pass several values at once, comma-separated. Some
          # possible values are:
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

          # Recipient email address
          # @return [String, nil]
          attr_accessor :email

          # Sender email address
          # @return [String, nil]
          attr_accessor :email_from

          # Recipient domain
          # @return [String, nil]
          attr_accessor :domain

          # Campaign identifier, unsigned decimal integer or UUID up to 128-bit, passed in metadata with name
          # "campaign_id" (name is configurable thru support).
          # @return [String, nil]
          attr_accessor :campaign_id

          def initialize(
            job_id: nil,
            status: nil,
            delivery_status: nil,
            email: nil,
            email_from: nil,
            domain: nil,
            campaign_id: nil
          )
            @job_id = job_id
            @status = status
            @delivery_status = delivery_status
            @email = email
            @email_from = email_from
            @domain = domain
            @campaign_id = campaign_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              job_id: data['job_id'],
              status: data['status'],
              delivery_status: data['delivery_status'],
              email: data['email'],
              email_from: data['email_from'],
              domain: data['domain'],
              campaign_id: data['campaign_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'job_id' => @job_id,
              'status' => @status,
              'delivery_status' => @delivery_status,
              'email' => @email,
              'email_from' => @email_from,
              'domain' => @domain,
              'campaign_id' => @campaign_id,
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
