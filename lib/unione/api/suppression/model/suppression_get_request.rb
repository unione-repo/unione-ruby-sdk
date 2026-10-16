# frozen_string_literal: true

module UniOne
  module Api
    module Suppression
      module Model
        # SuppressionGetRequest
        class SuppressionGetRequest
          # Email to get suppression details for.
          # @return [String, nil]
          attr_accessor :email

          # If a user has projects functionality enabled, he/she can pass all_projects=true to search in all
          # projects' data.
          # Default: `False`.
          # @return [Boolean, nil]
          attr_accessor :all_projects

          def initialize(
            email:,
            all_projects: nil
          )
            @email = email
            @all_projects = all_projects
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              all_projects: data['all_projects']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'all_projects' => @all_projects,
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
