# frozen_string_literal: true

module UniOne
  module Api
    module Tag
      module Model
        # TagDeleteRequest
        class TagDeleteRequest
          # Unique tag id.
          # @return [Integer, nil]
          attr_accessor :tag_id

          def initialize(
            tag_id:
          )
            @tag_id = tag_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              tag_id: data['tag_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'tag_id' => @tag_id,
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
