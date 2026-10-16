# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # Contains email headers, maximum 50. Only headers with “X-” name prefix are accepted, all other are
      # ignored, for example X-UNIONE-Global-Language, X-UNIONE-Template-Engine. Standard headers "To,"
      # "CC," and "BCC" are passed without the "X-." Yet, they are processed in a particular way and, as a
      # result, have a number of restrictions. You can find more details about it [here](/cc-and-bcc). If
      # our support have approved omitting standard unsubscription block for you, you can also pass
      # List-Unsubscribe, List-Subscribe, List-Help, List-Owner, List-Archive, In-Reply-To and References
      # headers.
      class HeadersObject
        # Wire names of the named fields
        FIELDS = ['X-UNIONE-Global-Language', 'X-UNIONE-Template-Engine'].freeze

        # The language of the unsubscribe footer and unsubscribe page. Languages supported are: "be", "de",
        # "en", "es", "fr", "it", "pl", "pt", "ru", "ua", "kz".
        # @return [String, nil]
        attr_accessor :x_unione_global_language

        # The template engine for handling the substitutions(merge tags), “simple”, “velocity”, “liquid” or
        # “none”. Default value is “simple”. Has a priority over the value allowed in the “template_engine”
        # parameter.
        # @return [String, nil]
        attr_accessor :x_unione_template_engine

        # Fields beyond the named ones, sent as is next to them (a named field wins), e.g. any X-* header,
        # 'CC', 'List-Unsubscribe': extra: { 'X-MyHeader' => 'some data' }. Unknown keys of a response go here
        # too.
        # @return [Hash{String => String}]
        attr_accessor :extra

        def initialize(
          x_unione_global_language: nil,
          x_unione_template_engine: nil,
          extra: {}
        )
          @x_unione_global_language = x_unione_global_language
          @x_unione_template_engine = x_unione_template_engine
          @extra = extra
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            x_unione_global_language: data['X-UNIONE-Global-Language'],
            x_unione_template_engine: data['X-UNIONE-Template-Engine'],
            extra: data.reject { |key, _| FIELDS.include?(key) }
          )
        end

        # JSON-ready hash, nil fields are omitted; the keys of extra go next to the named fields
        # (a named field wins).
        def to_h
          result = {
            'X-UNIONE-Global-Language' => @x_unione_global_language,
            'X-UNIONE-Template-Engine' => @x_unione_template_engine,
          }
          extra = (@extra || {}).transform_keys(&:to_s).reject { |key, value| result.key?(key) || value.nil? }
          extra.merge(result.compact)
        end

        def to_json(*args)
          to_h.to_json(*args)
        end
      end
    end
  end
end
