# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # EmailStatus
      module EmailStatus
        SENT = 'sent'
        DELIVERED = 'delivered'
        OPENED = 'opened'
        CLICKED = 'clicked'
        UNSUBSCRIBED = 'unsubscribed'
        SUBSCRIBED = 'subscribed'
        SOFT_BOUNCED = 'soft_bounced'
        HARD_BOUNCED = 'hard_bounced'
        SPAM = 'spam'

        # All values
        ALL = [SENT, DELIVERED, OPENED, CLICKED, UNSUBSCRIBED, SUBSCRIBED, SOFT_BOUNCED, HARD_BOUNCED, SPAM].freeze
      end
    end
  end
end
