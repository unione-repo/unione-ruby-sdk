# frozen_string_literal: true

module UniOne
  module Api
    module Project
      module Model
        # Object with project properties.
        class ProjectUpdateObject
          # Project name, unique for user account.
          # @return [String, nil]
          attr_accessor :name

          # ISO-3166 alpha-2 country code. If set, UniOne treats project personal data according to country
          # laws, e.g. GDPR for european countries.
          # @return [String, nil]
          attr_accessor :country

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

          # A unique identifier that defines the default unsubscribe page. If absent, the account/project will
          # be assigned the system default unsubscribe page.
          # @return [Integer, nil]
          attr_accessor :unsubscribe_page_id

          # Project's email counter value. 0 value only is accepted (which means resetting the counter to zero),
          # or refreshes automatically depending on the counter mode set with the 'email_counter_mode'
          # parameter. If the request doesn't contain the field or contains null, the limit value doesn't
          # change.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Allows you to limit the number of emails sent by the project. The sending stops when the limit is
          # reached. Any non-negative 64-bit integer is acceptable. Setting to 0 means no limit. If the request
          # doesn't contain the field or contains null, the limit value doesn't change.
          # Default: `0`.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # Sets the email counter mode. It allows you to choose whether the counter should reset automatically,
          # or remain permanent. The following values are acceptable: 'default' - the counter resets to zero
          # automatically at the beginning of each accounting period, 'permanent' - the counter never resets
          # automatically. The reset can be done only manually by the user in the request with the passes 0
          # value in the email_counter field. If the request doesn't contain the field or contains a null value,
          # the limit value doesn't change.
          # Default: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          def initialize(
            name:,
            country: nil,
            send_enabled: nil,
            custom_unsubscribe_url_enabled: nil,
            backend_domain_id: nil,
            unsubscribe_page_id: nil,
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil
          )
            @name = name
            @country = country
            @send_enabled = send_enabled
            @custom_unsubscribe_url_enabled = custom_unsubscribe_url_enabled
            @backend_domain_id = backend_domain_id
            @unsubscribe_page_id = unsubscribe_page_id
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              name: data['name'],
              country: data['country'],
              send_enabled: data['send_enabled'],
              custom_unsubscribe_url_enabled: data['custom_unsubscribe_url_enabled'],
              backend_domain_id: data['backend_domain_id'],
              unsubscribe_page_id: data['unsubscribe_page_id'],
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'name' => @name,
              'country' => @country,
              'send_enabled' => @send_enabled,
              'custom_unsubscribe_url_enabled' => @custom_unsubscribe_url_enabled,
              'backend_domain_id' => @backend_domain_id,
              'unsubscribe_page_id' => @unsubscribe_page_id,
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
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
