# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectCreateResponse
        class ProjectCreateResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Unqiue project identifier, ASCII string up to 36 characters long.
          # @return [String, nil]
          attr_accessor :project_id

          # API key of the project. You can use it instead of the user API key parameter in all methods except
          # project/* methods.
          # @return [String, nil]
          attr_accessor :project_api_key

          def initialize(
            status: nil,
            project_id: nil,
            project_api_key: nil
          )
            @status = status
            @project_id = project_id
            @project_api_key = project_api_key
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              project_id: data['project_id'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
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
