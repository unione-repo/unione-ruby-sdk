# frozen_string_literal: true

module UniOne
  module Api
    module Template
      module Model
        # TemplateListObject
        class TemplateListObject
          # Template unique identifier.
          # @return [String, nil]
          attr_accessor :id

          # Template name.
          # @return [String, nil]
          attr_accessor :name

          # Editor type, "html" or "visual". Default is "html". You can create a template with "visual" editor
          # type only in web interface.
          # @return [EditorType, nil]
          attr_accessor :editor_type

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

          # Sender's email.
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

          # Template creation date and time in UTC timezone in format "YYYY-MM-DD hh:mm:ss"
          # @return [String, nil]
          attr_accessor :created

          # Unique user identifier.
          # @return [Integer, nil]
          attr_accessor :user_id

          # Unqiue project identifier, ASCII string up to 36 characters long.
          # @return [String, nil]
          attr_accessor :project_id

          # Project name, unique for user account.
          # @return [String, nil]
          attr_accessor :project_name

          def initialize(
            id: nil,
            name: nil,
            editor_type: nil,
            template_engine: nil,
            global_substitutions: nil,
            global_metadata: nil,
            body: nil,
            subject: nil,
            from_email: nil,
            from_name: nil,
            reply_to: nil,
            reply_to_name: nil,
            track_links: nil,
            track_read: nil,
            headers: nil,
            attachments: nil,
            inline_attachments: nil,
            created: nil,
            user_id: nil,
            project_id: nil,
            project_name: nil
          )
            @id = id
            @name = name
            @editor_type = editor_type
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
            @headers = headers
            @attachments = attachments
            @inline_attachments = inline_attachments
            @created = created
            @user_id = user_id
            @project_id = project_id
            @project_name = project_name
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              id: data['id'],
              name: data['name'],
              editor_type: data['editor_type'],
              template_engine: data['template_engine'],
              global_substitutions: ::UniOne::Client::Decode.map(data['global_substitutions']),
              global_metadata: ::UniOne::Client::Decode.map(data['global_metadata']),
              body: ::UniOne::Client::Decode.model(::UniOne::Common::Model::BodyObject, data['body']),
              subject: data['subject'],
              from_email: data['from_email'],
              from_name: data['from_name'],
              reply_to: data['reply_to'],
              reply_to_name: data['reply_to_name'],
              track_links: data['track_links'],
              track_read: data['track_read'],
              headers: ::UniOne::Client::Decode.model(::UniOne::Common::Model::HeadersObject, data['headers']),
              attachments: ::UniOne::Client::Decode.list(data['attachments']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Common::Model::AttachmentsArrayItem, item0) },
              inline_attachments: ::UniOne::Client::Decode.list(data['inline_attachments']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Common::Model::InlineAttachmentsArrayItem, item0) },
              created: data['created'],
              user_id: data['user_id'],
              project_id: data['project_id'],
              project_name: data['project_name']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'id' => @id,
              'name' => @name,
              'editor_type' => @editor_type,
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
              'headers' => @headers.nil? ? nil : @headers.to_h,
              'attachments' => @attachments.nil? ? nil : @attachments.map { |item0| item0.to_h },
              'inline_attachments' => @inline_attachments.nil? ? nil : @inline_attachments.map { |item0| item0.to_h },
              'created' => @created,
              'user_id' => @user_id,
              'project_id' => @project_id,
              'project_name' => @project_name,
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
