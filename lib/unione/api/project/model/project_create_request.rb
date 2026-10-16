# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectCreateRequest
        class ProjectCreateRequest
          # Object with project properties.
          # @return [ProjectObject, nil]
          attr_accessor :project

          def initialize(
            project:
          )
            @project = project
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              project: ::UniOne::Client::Decode.model(::UniOne::Api::Project::Model::ProjectObject, data['project'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
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
