# frozen_string_literal: true

module UniOne
  module Api
    module Email
      module Model
        # Object containing all message properties.
        class MessageObject
          # Contains recipient emails, substitutions(merge tags) and metadata.
          # @return [Array<MessageObjectRecipientsItem>, nil]
          attr_accessor :recipients

          # Optional identifier of the template that had been created by
          # [template/set](https://docs.unione.io/en/web-api-ref#template-set) method. If template_id is passed
          # then fields from the template are used instead of missed email/send parameters. E.g. if "body"
          # parameter in email/send is omitted, "body" from template will be used. If "subject" in email/send is
          # omitted, "subject" from template will be used.
          # @return [String, nil]
          attr_accessor :template_id

          # An array of strings. The maximum string length is 100 characters. You can include up to 4 strings
          # which must be unique. No more than 10 000 tags are allowed per project; if you try to add more,
          # email/send will return an error. You may use tags to categorize emails by your own criteria, and
          # they will be passed along by event-dump methods.
          # @return [Array<String>, nil]
          attr_accessor :tags

          # Whether to skip or not appending default unsubscribe footer. 1=skip, 0=append, default is 0. You
          # should [ask support](https://cp.unione.io/en/support) to approve
          # usage of skip_unsubscribe=1. [Read more](https://docs.unione.io/en/unsubscribe-link).
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :skip_unsubscribe

          # The language of the unsubscribe footer and unsubscribe page. Languages supported are: "be", "de",
          # "en", "es", "fr", "it", "pl", "pt", "ru", "ua", "kz".
          # @return [String, nil]
          attr_accessor :global_language

          # The [template engine](https://docs.unione.io/en/template-engines) for handling the
          # substitutions(merge tags), "simple", "velocity", "liquid" or "none". Default value is "simple".
          # @return [TemplateEngine, nil]
          attr_accessor :template_engine

          # Object for passing the substitutions(merge tags) common for all recipients - e.g., company name. If
          # the substitution names are duplicated in object "substitutions", the values of the variables will be
          # taken from the object "substitutions". The substitutions can be used in the following parameters:
          #
          # - body.html
          # - body.plaintext
          # - body.amp
          # - subject
          # - from_name
          # - options.unsubscribe_url
          # A substitution name can consist from latin characeters, numbers and "_" symbol, and should start
          # with the letter.
          # @return [Hash{String => String}, nil]
          attr_accessor :global_substitutions

          # Object for passing the metadata common for all the recipients, such as "key": "value". Max key
          # quantity: 10. Max key length: 64 symbols. Max value length: 1024 symbols. The metadata is returned
          # by [webhook](https://docs.unione.io/en/web-api-ref#webhook). To group single emails into a campaign,
          # you can use the system key 'campaign_id' with a value in the form of a non-negative decimal integer
          # up to 128 bits or a UUID in the format 'c7703772-453e-4c77-a9ae-9a1b94051b5a'. Incorrect values will
          # be treated as '0'.
          # @return [Hash{String => String}, nil]
          attr_accessor :global_metadata

          # Contains HTML/plaintext/AMP parts of the email. Either html or plaintext part is required.
          # @return [BodyObject, nil]
          attr_accessor :body

          # Email subject.
          # @return [String, nil]
          attr_accessor :subject

          # Sender's email. Required only if template_id parameter is empty.
          # @return [String, nil]
          attr_accessor :from_email

          # Sender's name.
          # @return [String, nil]
          attr_accessor :from_name

          # Optional Reply-To email (in case it's different to sender's email)
          # @return [String, nil]
          attr_accessor :reply_to

          # Optional Reply-To name (if reply_to email is specified and you want to display not only this email
          # but also the name)
          # @return [String, nil]
          attr_accessor :reply_to_name

          # 1 = click tracking is on (default), 0 = click tracking is off. To use track_links = 0, you need to
          # ask support to enable this feature.
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :track_links

          # 1 = read tracking is on (default), 0=read tracking is off. To use track_read = 0, you need to ask
          # support to enable this feature.
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :track_read

          # (allowed values 0 or 1, default 0) If set to 1, the global unavailability list will be ignored. Even
          # if the address was found to be unreachable while sending other UniOne users' emails, or its owner
          # has issued complaints, the message will still be sent. The setting may be ignored for certain
          # addresses.
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :bypass_global

          # (allowed values 0 or 1, default 0) If set to 1, the current user's or project's unavailability list
          # will be ignored. Works only if bypass_global is set to 1.
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :bypass_unavailable

          # (allowed values 0 or 1, default 0) If set to 1, the current list of unsubscribed addresses for this
          # account or project will be ignored. Works only if bypass_global is set to 1. The setting is
          # available only for users that have been granted the right to omit the unsubscribe link (to request,
          # please contact [support](https://cp.unione.io/en/support)).
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :bypass_unsubscribed

          # (allowed values 0 or 1, default 0) If set to 1, the user's or project's complaint list will be
          # ignored. Works only if bypass_global is set to 1. The setting is available only for users that have
          # been granted the right to omit the unsubscribe link (to request, please contact
          # [support](https://cp.unione.io/en/support)).
          # Allowed values: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :bypass_complained

          # A string of up to 64 characters containing a unique message key. This can be used to prevent
          # occasional message duplicates. If you send another API request with the same message key within the
          # next minute, it will be declined. We can generate a message key for each letter automatically; to
          # enable this option, please contact our [tech support](https://cp.unione.io/en/support).
          # @return [String, nil]
          attr_accessor :idempotence_key

          # Contains email headers, maximum 50. Only headers with “X-” name prefix are accepted, all other are
          # ignored, for example X-UNIONE-Global-Language, X-UNIONE-Template-Engine. Standard headers "To,"
          # "CC," and "BCC" are passed without the "X-." Yet, they are processed in a particular way and, as a
          # result, have a number of restrictions. You can find more details about it [here](/cc-and-bcc). If
          # our support have approved omitting standard unsubscription block for you, you can also pass
          # List-Unsubscribe, List-Subscribe, List-Help, List-Owner, List-Archive, In-Reply-To and References
          # headers.
          # @return [HeadersObject, nil]
          attr_accessor :headers

          # Optional array of attachments
          # @return [Array<AttachmentsArrayItem>, nil]
          attr_accessor :attachments

          # Optional array of inline attachments, e.g. for including images in email instead of loading them
          # from external URL.
          # @return [Array<InlineAttachmentsArrayItem>, nil]
          attr_accessor :inline_attachments

          # Additional message options.
          # @return [MessageObjectOptions, nil]
          attr_accessor :options

          def initialize(
            recipients:,
            body:,
            subject:,
            template_id: nil,
            tags: nil,
            skip_unsubscribe: nil,
            global_language: nil,
            template_engine: nil,
            global_substitutions: nil,
            global_metadata: nil,
            from_email: nil,
            from_name: nil,
            reply_to: nil,
            reply_to_name: nil,
            track_links: nil,
            track_read: nil,
            bypass_global: nil,
            bypass_unavailable: nil,
            bypass_unsubscribed: nil,
            bypass_complained: nil,
            idempotence_key: nil,
            headers: nil,
            attachments: nil,
            inline_attachments: nil,
            options: nil
          )
            @recipients = recipients
            @template_id = template_id
            @tags = tags
            @skip_unsubscribe = skip_unsubscribe
            @global_language = global_language
            @template_engine = template_engine
            @global_substitutions = global_substitutions
            @global_metadata = global_metadata
            @body = body
            @subject = subject
            @from_email = from_email
            @from_name = from_name
            @reply_to = reply_to
            @reply_to_name = reply_to_name
            @track_links = track_links
            @track_read = track_read
            @bypass_global = bypass_global
            @bypass_unavailable = bypass_unavailable
            @bypass_unsubscribed = bypass_unsubscribed
            @bypass_complained = bypass_complained
            @idempotence_key = idempotence_key
            @headers = headers
            @attachments = attachments
            @inline_attachments = inline_attachments
            @options = options
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              recipients: ::UniOne::Client::Decode.list(data['recipients']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Email::Model::MessageObjectRecipientsItem, item0) },
              body: ::UniOne::Client::Decode.model(::UniOne::Common::Model::BodyObject, data['body']),
              subject: data['subject'],
              template_id: data['template_id'],
              tags: ::UniOne::Client::Decode.list(data['tags']),
              skip_unsubscribe: data['skip_unsubscribe'],
              global_language: data['global_language'],
              template_engine: data['template_engine'],
              global_substitutions: ::UniOne::Client::Decode.map(data['global_substitutions']),
              global_metadata: ::UniOne::Client::Decode.map(data['global_metadata']),
              from_email: data['from_email'],
              from_name: data['from_name'],
              reply_to: data['reply_to'],
              reply_to_name: data['reply_to_name'],
              track_links: data['track_links'],
              track_read: data['track_read'],
              bypass_global: data['bypass_global'],
              bypass_unavailable: data['bypass_unavailable'],
              bypass_unsubscribed: data['bypass_unsubscribed'],
              bypass_complained: data['bypass_complained'],
              idempotence_key: data['idempotence_key'],
              headers: ::UniOne::Client::Decode.model(::UniOne::Common::Model::HeadersObject, data['headers']),
              attachments: ::UniOne::Client::Decode.list(data['attachments']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Common::Model::AttachmentsArrayItem, item0) },
              inline_attachments: ::UniOne::Client::Decode.list(data['inline_attachments']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Common::Model::InlineAttachmentsArrayItem, item0) },
              options: ::UniOne::Client::Decode.model(::UniOne::Api::Email::Model::MessageObjectOptions, data['options'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'recipients' => @recipients.nil? ? nil : @recipients.map { |item0| item0.to_h },
              'template_id' => @template_id,
              'tags' => @tags,
              'skip_unsubscribe' => @skip_unsubscribe,
              'global_language' => @global_language,
              'template_engine' => @template_engine,
              'global_substitutions' => @global_substitutions,
              'global_metadata' => @global_metadata,
              'body' => @body.nil? ? nil : @body.to_h,
              'subject' => @subject,
              'from_email' => @from_email,
              'from_name' => @from_name,
              'reply_to' => @reply_to,
              'reply_to_name' => @reply_to_name,
              'track_links' => @track_links,
              'track_read' => @track_read,
              'bypass_global' => @bypass_global,
              'bypass_unavailable' => @bypass_unavailable,
              'bypass_unsubscribed' => @bypass_unsubscribed,
              'bypass_complained' => @bypass_complained,
              'idempotence_key' => @idempotence_key,
              'headers' => @headers.nil? ? nil : @headers.to_h,
              'attachments' => @attachments.nil? ? nil : @attachments.map { |item0| item0.to_h },
              'inline_attachments' => @inline_attachments.nil? ? nil : @inline_attachments.map { |item0| item0.to_h },
              'options' => @options.nil? ? nil : @options.to_h,
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
