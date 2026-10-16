# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # ProjectListObject
        class ProjectListObject
          # Unqiue project identifier, ASCII string up to 36 characters long.
          # @return [String, nil]
          attr_accessor :id

          # API key of the project. You can use it instead of the user API key parameter in all methods except
          # project/* methods.
          # @return [String, nil]
          attr_accessor :api_key

          # Project name, unique for user account.
          # @return [String, nil]
          attr_accessor :name

          # ISO-3166 alpha-2 country code. If set, UniOne treats project personal data according to country
          # laws, e.g. GDPR for european countries.
          # @return [String, nil]
          attr_accessor :country

          # Date and time of project creation in UTC timezone in "YYYY-MM-DD hh:mm:ss" format.
          # @return [String, nil]
          attr_accessor :reg_time

          # Whether email sending is enabled for this project or not.
          # Default: `True`.
          # @return [Boolean, nil]
          attr_accessor :send_enabled

          # If it's false then UniOne adds default unsubscribe footer to each email sent with API key of the
          # project. If it's true then appending default unsubscribe footer for this project is avoided and
          # sending with custom unsubscribe url or even without unsubscribe url is permitted for the project.
          # Please note that custom_unsubscribe_url_enabled=true is available only if removing unsubscribe link
          # is approved for the user account by support. More on this
          # [here](https://docs.unione.io/en/unsubscribe-link). When custom_unsubscribe_url_enabled is skipped
          # on creating a project, it's value is taken from user
          # @return [Boolean, nil]
          attr_accessor :custom_unsubscribe_url_enabled

          # A unique domain identifier which will determine the [tracking
          # domain](https://docs.unione.io/en/tracking-domains) or [dedicated IP](/dedicated-ip) pool to be used
          # by default. If the value is not specified, a default backend domain will be assigned for your
          # account or project instead.
          # @return [Integer, nil]
          attr_accessor :backend_domain_id

          # Project's email counter value. It increases on every email sent.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Allows you to limit the number of emails sent by the project. The sending stops when the limit is
          # reached. Any non-negative 64-bit integer is acceptable. 0 means no limit.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # 'default' - the counter resets to zero automatically at the beginning of each accounting period.
          # 'permanent' - the counter never resets automatically.
          # Default: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          # A unique identifier that defines the default unsubscribe page. If absent, the account/project will
          # be assigned the system default unsubscribe page.
          # @return [Integer, nil]
          attr_accessor :unsubscribe_page_id

          def initialize(
            id: nil,
            api_key: nil,
            name: nil,
            country: nil,
            reg_time: nil,
            send_enabled: nil,
            custom_unsubscribe_url_enabled: nil,
            backend_domain_id: nil,
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil,
            unsubscribe_page_id: nil
          )
            @id = id
            @api_key = api_key
            @name = name
            @country = country
            @reg_time = reg_time
            @send_enabled = send_enabled
            @custom_unsubscribe_url_enabled = custom_unsubscribe_url_enabled
            @backend_domain_id = backend_domain_id
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
            @unsubscribe_page_id = unsubscribe_page_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              id: data['id'],
              api_key: data['api_key'],
              name: data['name'],
              country: data['country'],
              reg_time: data['reg_time'],
              send_enabled: data['send_enabled'],
              custom_unsubscribe_url_enabled: data['custom_unsubscribe_url_enabled'],
              backend_domain_id: data['backend_domain_id'],
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode'],
              unsubscribe_page_id: data['unsubscribe_page_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'id' => @id,
              'api_key' => @api_key,
              'name' => @name,
              'country' => @country,
              'reg_time' => @reg_time,
              'send_enabled' => @send_enabled,
              'custom_unsubscribe_url_enabled' => @custom_unsubscribe_url_enabled,
              'backend_domain_id' => @backend_domain_id,
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
              'unsubscribe_page_id' => @unsubscribe_page_id,
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
