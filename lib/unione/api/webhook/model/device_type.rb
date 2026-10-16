# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Recipient's device type, detected from the user agent. Present for "clicked" and "opened" statuses;
        # equals "unknown" if the device type couldn't be detected.
        module DeviceType
          DESKTOP = 'desktop'
          MOBILE = 'mobile'
          TABLET = 'tablet'
          OTHER = 'other'
          UNKNOWN = 'unknown'

          # All values
          ALL = [DESKTOP, MOBILE, TABLET, OTHER, UNKNOWN].freeze
        end
      end
    end
  end
end
