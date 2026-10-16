# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Spam block type, either single or multiple sending SMTP. For single sending SMTP block in common
        # pool UniOne retries several other SMTPs. This property exists only if
        # event_name="transactional_spam_block".
        module BlockType
          ONE_SMTP = 'one_smtp'
          ALL_SMTP = 'all_smtp'

          # All values
          ALL = [ONE_SMTP, ALL_SMTP].freeze
        end
      end
    end
  end
end
