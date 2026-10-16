# frozen_string_literal: true

module UniOne
  module Api
    module Template
      module Model
        # TemplateListResponse
        class TemplateListResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Array of template objects.
          # @return [Array<TemplateListObject>, nil]
          attr_accessor :templates

          def initialize(
            status: nil,
            templates: nil
          )
            @status = status
            @templates = templates
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              templates: ::UniOne::Client::Decode.list(data['templates']) { |item0| ::UniOne::Client::Decode.model(::UniOne::Api::Template::Model::TemplateListObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'templates' => @templates.nil? ? nil : @templates.map { |item0| item0.to_h },
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
