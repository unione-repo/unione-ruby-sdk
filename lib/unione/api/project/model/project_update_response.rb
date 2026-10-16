# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectUpdateResponse
        class ProjectUpdateResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # API key of the project. Returned only if the project to update was identified by project_api_key.
          # Not returned in case of updating by project_id.
          # @return [String, nil]
          attr_accessor :project_api_key

          def initialize(
            status: nil,
            project_api_key: nil
          )
            @status = status
            @project_api_key = project_api_key
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
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
