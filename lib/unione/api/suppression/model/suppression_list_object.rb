# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # Object with suppression details.
        class SuppressionListObject
          # Email to get suppression details for.
          # @return [String, nil]
          attr_accessor :email

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

          # Is it possible to delete this suppression by calling suppression/delete method.
          # @return [Boolean, nil]
          attr_accessor :is_deletable

          # When suppression was created, in UTC timezone in "YYYY-MM-DD hh:mm:ss" format.
          # @return [String, nil]
          attr_accessor :created

          def initialize(
            email: nil,
            cause: nil,
            source: nil,
            is_deletable: nil,
            created: nil
          )
            @email = email
            @cause = cause
            @source = source
            @is_deletable = is_deletable
            @created = created
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              cause: data['cause'],
              source: data['source'],
              is_deletable: data['is_deletable'],
              created: data['created']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'cause' => @cause,
              'source' => @source,
              'is_deletable' => @is_deletable,
              'created' => @created,
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
