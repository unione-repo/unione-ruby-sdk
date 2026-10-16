# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Whether it's a block or unblock event. This property exists only if
        # event_name="transactional_spam_block".
        module DomainStatus
          BLOCKED = 'blocked'
          UNBLOCKED = 'unblocked'

          # All values
          ALL = [BLOCKED, UNBLOCKED].freeze
        end
      end
    end
  end
end
