# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # SuppressionListRequest
        class SuppressionListRequest
          # Cause of email being suppressed. One of:
          #
          # - __unsubscribed__ - email is unsubscribed;
          # - __temporary_unavailable__ - the email address is unavailable. This means that over the next three days sending to this address will return an error. Email may be temporarily unavailable due to several reasons, e.g.:
          #
          # - a previous email has been rejected by the recipient's server for spam;
          # - the recipient's mailbox is full or is not used;
          # - recipient's domain does not accept mail;
          # - sending server was rejected due to blacklisting;
          #
          # - __permanent_unavailable__ - the email address is permanently unavailable due to multiple hard bounces;
          # - __complained__ -  the recipient reported spam in the previous emails;
          # - __blocked__ -  sending to the email is prohibited by administration of UniOne.
          # We may add some new causes in the future.
          # @return [String, nil]
          attr_accessor :cause

          # Source of email being suppressed. One of:
          #
          # - __user__ - suppressed by user with    [suppression/set](https://docs.unione.io/en/web-api-ref#suppression-set);
          # - __system__ - sending to the email is prohibited by system, for example due to multiple hard bounces;
          # - __subscriber__ - the recipient reported spam or unsubscribed in the previous emails.
          # @return [String, nil]
          attr_accessor :source

          # Date in the format YYYY-MM-DD hh:mm:ss to get suppression list from the "start_time" to the present
          # day. Ignored if "cursor" is not empty.
          # @return [String, nil]
          attr_accessor :start_time

          # The parameter indicates from which position the selection is to be started. Must be empty or omitted
          # for the first data chunk. In order to get subsequent chunks, you must set the "cursor" parameter in
          # your request, using the value received in response to the previous request.
          # @return [String, nil]
          attr_accessor :cursor

          # Limits the number of records to be returned at one time, default is 50.
          # @return [Integer, nil]
          attr_accessor :limit

          def initialize(
            cause: nil,
            source: nil,
            start_time: nil,
            cursor: nil,
            limit: nil
          )
            @cause = cause
            @source = source
            @start_time = start_time
            @cursor = cursor
            @limit = limit
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              cause: data['cause'],
              source: data['source'],
              start_time: data['start_time'],
              cursor: data['cursor'],
              limit: data['limit']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'cause' => @cause,
              'source' => @source,
              'start_time' => @start_time,
              'cursor' => @cursor,
              'limit' => @limit,
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
