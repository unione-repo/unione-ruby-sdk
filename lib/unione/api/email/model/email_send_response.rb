# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # EmailSendResponse
        class EmailSendResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Job identifier, might be useful for investigating errors.
          # @return [String, nil]
          attr_accessor :job_id

          # Array of recipients emails successfully accepted for sending.
          # @return [Array<String>, nil]
          attr_accessor :emails

          # Object with emails rejected for sending as property names and their statuses as property values,
          # e.g.: {"email1@gmail.com": "temporary_unavailable"}. Possible statuses:
          #
          # - __unsubscribed__ - specified email is unsubscribed;
          # - __invalid__ - the email does not exist or has been entered incorrectly;
          # - __duplicate__ - the email already exists in the request, email duplicating is prevented;
          # - __temporary_unavailable__ - the email address is unavailable. This means that over the next three days sending to this address will return an error. Email may be temporarily unavailable due to several reasons, e.g.:
          #
          # - a previous email has been rejected by the recipient's server for spam;
          # - the recipient's mailbox is full or is not used;
          # - recipient's domain does not accept mail;
          # - sending server was rejected due to blacklisting;
          #
          # - __permanent_unavailable__ - the email address is permanently unavailable or unsubscribed globally.
          # - __complained__ -  the recipient reported spam in the previous emails;
          # - __blocked__ -  sending to the email is prohibited by administration of UniOne.
          # We may added new statuses in the future.
          # @return [Hash{String => String}, nil]
          attr_accessor :failed_emails

          def initialize(
            status: nil,
            job_id: nil,
            emails: nil,
            failed_emails: nil
          )
            @status = status
            @job_id = job_id
            @emails = emails
            @failed_emails = failed_emails
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              job_id: data['job_id'],
              emails: ::UniOne::Client::Decode.list(data['emails']),
              failed_emails: ::UniOne::Client::Decode.map(data['failed_emails'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'job_id' => @job_id,
              'emails' => @emails,
              'failed_emails' => @failed_emails,
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
