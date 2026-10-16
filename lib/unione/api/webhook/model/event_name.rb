# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Type of event data contained in event_data field, either "transactional_email_status" or
        # "transactional_spam_block".
        module EventName
          TRANSACTIONAL_EMAIL_STATUS = 'transactional_email_status'
          TRANSACTIONAL_SPAM_BLOCK = 'transactional_spam_block'

          # All values
          ALL = [TRANSACTIONAL_EMAIL_STATUS, TRANSACTIONAL_SPAM_BLOCK].freeze
        end
      end
    end
  end
end
