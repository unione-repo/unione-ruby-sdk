# frozen_string_literal: true

module UniOne
  # Entry point of the UniOne API: one method per section.
  #
  #   client = UniOne.client('YOUR_API_KEY')
  #   client.email.send_email(...)
  class UniOneClient
    # @return [Client::ApiClient]
    attr_reader :api_client

    # @param api_key [String]
    # @param host [String, nil] API host (Client::Configuration::HOST_US1, 'us1.unione.io') or a full base URL
    # @param transport [#call, nil] HTTP layer: call(method, uri, headers, body, timeout) -> [status, body];
    #   nil: Client::NetHttpTransport
    # @param options [Hash] of Client::Configuration: timeout:, platform:, headers: (extra HTTP headers)
    def initialize(api_key, host = nil, transport: nil, **options)
      options = options.merge(base_url: Client::Configuration.base_url_for(host)) if host
      @api_client = Client::ApiClient.new(Client::Configuration.new(api_key, **options), transport: transport)
    end

    # This group of methods is related with email sending.
    # @return [Api::Email::EmailApi]
    def email
      @email ||= Api::Email::EmailApi.new(@api_client)
    end

    # Email validation methods. As a result of the check, you’ll get detailed information on email
    # validity. It will help eliminate nonexistent emails, decrease the number of complaints, clean up the
    # subscribers list and eventually enhance your sender reputation score. For example, you may add
    # validation to a subscription form on your site to let users know they’ve just entered an invalid
    # address.
    # @return [Api::EmailValidation::EmailValidationApi]
    def email_validation
      @email_validation ||= Api::EmailValidation::EmailValidationApi.new(@api_client)
    end

    # Manage email addresses confirmed for sandbox-domain sending. These methods are available only with a
    # main account API key.
    # @return [Api::ConfirmedEmail::ConfirmedEmailApi]
    def confirmed_email
      @confirmed_email ||= Api::ConfirmedEmail::ConfirmedEmailApi.new(@api_client)
    end

    # You have the option of storing a template on the UniOne side and then using it by id, which is
    # highly recommended for sending repetitive messages or high volume traffic. UniOne supports two
    # different [template engines](https://docs.unione.io/en/template-engines).
    # @return [Api::Template::TemplateApi]
    def template
      @template ||= Api::Template::TemplateApi.new(@api_client)
    end

    # UniOne lets you recieve notifications about email status changes or spam blocks. You provide an URL
    # and every time a watched event occurs we will notify you by submitting a request with JSON data to
    # this URL.
    # @return [Api::Webhook::WebhookApi]
    def webhook
      @webhook ||= Api::Webhook::WebhookApi.new(@api_client)
    end

    # Methods for managing suppression lists. An email can be added to suppression list because of
    # unsubscription, bounce or complain.
    # @return [Api::Suppression::SuppressionApi]
    def suppression
      @suppression ||= Api::Suppression::SuppressionApi.new(@api_client)
    end

    # You can use these methods to setup sender domains and check their statuses. They might be useful in
    # case you want to automate adding domains for your own clients.
    # @return [Api::Domain::DomainApi]
    def domain
      @domain ||= Api::Domain::DomainApi.new(@api_client)
    end

    # These methods are used to obtain a list of events for a given period of time. The data is stored for
    # up to 45 days, depending on your tariff, i. e. you may fetch all event data starting from 00:00:00
    # 31 days ago and up to current time. For custom tarifs with big sending volumes event dumps are
    # available only for the last 7 days.
    # @return [Api::EventDump::EventDumpApi]
    def event_dump
      @event_dump ||= Api::EventDump::EventDumpApi.new(@api_client)
    end

    # This family of methods is used to manage user-defined tags. Tags are used to categorize letters
    # based on your own criteria, e. g. to create a distinction between marketing and transactional
    # letters or group together all notifications for a particular order type. UniOne allows you to assign
    # tags to all outgoing emails, and the tags you’ve set may then be used to filter and analyze delivery
    # statistics.
    # @return [Api::Tag::TagApi]
    def tag
      @tag ||= Api::Tag::TagApi.new(@api_client)
    end

    # Projects allow you to group several independent domains, webhooks, templates, and unsubscription
    # lists together. It's very useful if you have your own clients and manage their data from a single
    # UniOne account. Each project receives its own API key, and all API calls with that API key only deal
    # with the data of that project. This way, you can assign a separate project for each client and be
    # sure that they won't conflict; e.g. unsubscribing from one project won't affect another.
    # @return [Api::Project::ProjectApi]
    def project
      @project ||= Api::Project::ProjectApi.new(@api_client)
    end

    # System operations.
    # @return [Api::System::SystemApi]
    def system
      @system ||= Api::System::SystemApi.new(@api_client)
    end

    # Obsolete methods dealing with unsubscribes. We recommend using the more flexible
    # [suppression](https://docs.unione.io/en/web-api-ref#suppression) methods instead. Note that you
    # can't resubscribe an unsubscribed recipient using WebAPI, but you can send him an email with
    # subscription link using email/subscribe method.
    # @return [Api::Obsolete::ObsoleteApi]
    def obsolete
      @obsolete ||= Api::Obsolete::ObsoleteApi.new(@api_client)
    end
  end

  # Shortcut: UniOne.client('YOUR_API_KEY')
  # @param host [String, nil] API host, e.g. 'us1.unione.io', or a full base URL
  # @param options [Hash] transport:, timeout:, platform:, headers: (see UniOneClient#initialize)
  # @return [UniOneClient]
  def self.client(api_key, host = nil, **options)
    UniOneClient.new(api_key, host, **options)
  end
end
