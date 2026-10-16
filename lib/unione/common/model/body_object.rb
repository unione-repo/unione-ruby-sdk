# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # Contains HTML/plaintext/AMP parts of the email. Either html or plaintext part is required.
      class BodyObject
        # HTML part of the email body
        # @return [String, nil]
        attr_accessor :html

        # Plaintext part of the email body.
        # @return [String, nil]
        attr_accessor :plaintext

        # Optional [AMP](http://amp.dev/documentation/guides-and-tutorials/learn/email_fundamentals/) part of
        # the email body.
        # @return [String, nil]
        attr_accessor :amp

        def initialize(
          html: nil,
          plaintext: nil,
          amp: nil
        )
          @html = html
          @plaintext = plaintext
          @amp = amp
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            html: data['html'],
            plaintext: data['plaintext'],
            amp: data['amp']
          )
        end

        # JSON-ready hash, nil fields are omitted.
        def to_h
          {
            'html' => @html,
            'plaintext' => @plaintext,
            'amp' => @amp,
          }.compact
        end

        def to_json(*args)
          to_h.to_json(*args)
        end
      end
    end
  end
end
