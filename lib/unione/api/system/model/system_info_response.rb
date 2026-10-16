# frozen_string_literal: true

module UniOne
  module Api
    module System
      module Model
        # SystemInfoResponse
        class SystemInfoResponse
          # "success" string
          # Allowed values: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Unique user identifier.
          # @return [Integer, nil]
          attr_accessor :user_id

          # Email of the user.
          # @return [String, nil]
          attr_accessor :email

          # Unqiue project identifier, ASCII string up to 36 characters long. Present only if the API key used
          # for request is the project API key.
          # @return [String, nil]
          attr_accessor :project_id

          # Project name, unique for user account. Present only if the API key used for request is the project
          # API key.
          # @return [String, nil]
          attr_accessor :project_name

          # Object with email counter properties. Present only if the API key used for request is the user API
          # key.
          # @return [ProjectAccountingObject, nil]
          attr_accessor :project_accounting

          # Object with accounting period properties. Present only if the API key used for request is the user
          # API key.
          # @return [SystemInfoResponseAccounting, nil]
          attr_accessor :accounting

          def initialize(
            status: nil,
            user_id: nil,
            email: nil,
            project_id: nil,
            project_name: nil,
            project_accounting: nil,
            accounting: nil
          )
            @status = status
            @user_id = user_id
            @email = email
            @project_id = project_id
            @project_name = project_name
            @project_accounting = project_accounting
            @accounting = accounting
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              user_id: data['user_id'],
              email: data['email'],
              project_id: data['project_id'],
              project_name: data['project_name'],
              project_accounting: ::UniOne::Client::Decode.model(::UniOne::Api::System::Model::ProjectAccountingObject, data['project_accounting']),
              accounting: ::UniOne::Client::Decode.model(::UniOne::Api::System::Model::SystemInfoResponseAccounting, data['accounting'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'user_id' => @user_id,
              'email' => @email,
              'project_id' => @project_id,
              'project_name' => @project_name,
              'project_accounting' => @project_accounting.nil? ? nil : @project_accounting.to_h,
              'accounting' => @accounting.nil? ? nil : @accounting.to_h,
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
