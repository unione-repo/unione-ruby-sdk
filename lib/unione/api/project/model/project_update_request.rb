# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectUpdateRequest
        class ProjectUpdateRequest
          # Unique project identifier. You should identify project to update either with project_id or with
          # project_api_key field. But we recommend usage of project_id as a more secure option.
          # @return [String, nil]
          attr_accessor :project_id

          # Optional project API key. You should identify project to update either with project_id or with
          # project_api_key field. But we recommend usage of project_id as a more secure option.
          # @return [String, nil]
          attr_accessor :project_api_key

          # Object with project properties.
          # @return [ProjectUpdateObject, nil]
          attr_accessor :project

          def initialize(
            project:,
            project_id: nil,
            project_api_key: nil
          )
            @project_id = project_id
            @project_api_key = project_api_key
            @project = project
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              project: ::UniOne::Client::Decode.model(::UniOne::Api::Project::Model::ProjectUpdateObject, data['project']),
              project_id: data['project_id'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'project_id' => @project_id,
              'project_api_key' => @project_api_key,
              'project' => @project.nil? ? nil : @project.to_h,
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
