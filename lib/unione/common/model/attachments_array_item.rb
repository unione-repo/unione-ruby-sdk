# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # AttachmentsArrayItem
      class AttachmentsArrayItem
        # Attachment type, see [MIME](https://en.wikipedia.org/wiki/MIME). If unsure, use
        # "application/octet-stream".
        # @return [String, nil]
        attr_accessor :type

        # Attachment name in the format: "name.extension". When multiple attachments are passed, their names
        # must be unique. The symbol ‘/’ is not allowed in attachment names.
        # @return [String, nil]
        attr_accessor :name

        # File contents in [base64](https://en.wikipedia.org/wiki/Base64). Maximum file size 7MB (9786710
        # bytes in base64).
        # @return [String, nil]
        attr_accessor :content

        def initialize(
          type:,
          name:,
          content:
        )
          @type = type
          @name = name
          @content = content
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            type: data['type'],
            name: data['name'],
            content: data['content']
          )
        end

        # JSON-ready hash, nil fields are omitted.
        def to_h
          {
            'type' => @type,
            'name' => @name,
            'content' => @content,
          }.compact
        end

        def to_json(*args)
          to_h.to_json(*args)
        end
      end
    end
  end
end
