# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectDeleteRequest
        class ProjectDeleteRequest
          # Unique project identifier. You should identify project to delete either with project_id or with
          # project_api_key field. We recommend usage of project_id as a more secure option.
          # @return [String, nil]
          attr_accessor :project_id

          # Optional project API key. You should identify project to delete either with project_id or with
          # project_api_key field. We recommend usage of project_id as a more secure option.
          # @return [String, nil]
          attr_accessor :project_api_key

          def initialize(
            project_id: nil,
            project_api_key: nil
          )
            @project_id = project_id
            @project_api_key = project_api_key
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              project_id: data['project_id'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'project_id' => @project_id,
              'project_api_key' => @project_api_key,
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
