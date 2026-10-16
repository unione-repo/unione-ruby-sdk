# frozen_string_literal: true

module UniOne
  module Api
    module EmailValidation
      module Model
        # EmailValidationSingleResponse
        class EmailValidationSingleResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Email address to be checked.
          # @return [String, nil]
          attr_accessor :email

          # Possible statuses:
          #
          # - "valid" - the address is valid,
          # - "invalid" - the address is invalid,
          # - "suspicious" - the address looks suspicious,
          # - "unknown" - could not perform validation, the domain’s mail server has not responded within the time limit.
          # @return [String, nil]
          attr_accessor :result

          # Possible statuses:
          #
          # - "no_mx_record" - no MX record found for the target domain,
          # - "syntax_error" - the address syntax is invalid,
          # - "possible_typo" - the address is likely to have a typo,
          # - "mailbox_not_found" - the address does not exist,
          # - "global_suppression" - the address has been marked as unreachable due to multiple previous delivery errors,
          # - "disposable" - this is a disposable one-time email address which is usually valid for a few minutes only,
          # - "role" - the address is not likely to belong to an actual person, but rather to a certain business staff role,
          # - "abuse" - the address is known to be a source of a large number of complaints, sometimes issued automatically,
          # - "spamtrap" - this email is a spam trap, it is published openly but never used for actual emails. Sending messages to such addresses has a huge negative impact on reputation score,
          # - "smtp_connection_failed" - the domain’s SMTP server does not respond; the address may contain a typo.
          # @return [String, nil]
          attr_accessor :cause

          # Validity score, from 0 to 100 (0 – invalid, 100 – valid).
          # @return [Integer, nil]
          attr_accessor :validity

          # Local part (everything preceding the @ sign).
          # @return [String, nil]
          attr_accessor :local_part

          # Domain name part.
          # @return [String, nil]
          attr_accessor :domain

          # True if the address’ domain does have an MX record, false if does not.
          # @return [Boolean, nil]
          attr_accessor :mx_found

          # Preferred MX record for the domain.
          # @return [String, nil]
          attr_accessor :mx_record

          # For addresses which are likely to have typing errors (cause=possible_typo), a suggested variant with
          # a fixed typo.
          # @return [String, nil]
          attr_accessor :did_you_mean

          # Email check date and time, YYYY-MM-DD hh:mm:ss UTC.
          # @return [String, nil]
          attr_accessor :processed_at

          def initialize(
            status: nil,
            email: nil,
            result: nil,
            cause: nil,
            validity: nil,
            local_part: nil,
            domain: nil,
            mx_found: nil,
            mx_record: nil,
            did_you_mean: nil,
            processed_at: nil
          )
            @status = status
            @email = email
            @result = result
            @cause = cause
            @validity = validity
            @local_part = local_part
            @domain = domain
            @mx_found = mx_found
            @mx_record = mx_record
            @did_you_mean = did_you_mean
            @processed_at = processed_at
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              email: data['email'],
              result: data['result'],
              cause: data['cause'],
              validity: data['validity'],
              local_part: data['local_part'],
              domain: data['domain'],
              mx_found: data['mx_found'],
              mx_record: data['mx_record'],
              did_you_mean: data['did_you_mean'],
              processed_at: data['processed_at']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'email' => @email,
              'result' => @result,
              'cause' => @cause,
              'validity' => @validity,
              'local_part' => @local_part,
              'domain' => @domain,
              'mx_found' => @mx_found,
              'mx_record' => @mx_record,
              'did_you_mean' => @did_you_mean,
              'processed_at' => @processed_at,
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
