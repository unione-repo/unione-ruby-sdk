# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Webhook status, "active" by default. "disabled" means that webhook has been disabled by the user,
        # "stopped" means that webhook has been stopped by the system after 24h of failed calls (with minimum
        # of 10 distinct events).
        module WebhookStatus
          ACTIVE = 'active'
          DISABLED = 'disabled'
          STOPPED = 'stopped'

          # All values
          ALL = [ACTIVE, DISABLED, STOPPED].freeze
        end
      end
    end
  end
end
