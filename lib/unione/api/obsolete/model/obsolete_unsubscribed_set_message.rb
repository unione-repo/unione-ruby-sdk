# frozen_string_literal: true

module UniOne
  module Api
    module Obsolete
      module Model
        # Unsubscription process details:
        #
        # - "unsubscribed" if email has just been unsubscribed,
        # - "was inactive" if it was inactive due some reason,
        # - "was unsubscribed" if it already was unsubscribed before the call,
        # - "added and unsubscribed" if it's a new email without status history and it was added and then unsubscribed immediately.
        module ObsoleteUnsubscribedSetMessage
          UNSUBSCRIBED = 'unsubscribed'
          WAS_INACTIVE = 'was inactive'
          WAS_UNSUBSCRIBED = 'was unsubscribed'
          ADDED_AND_UNSUBSCRIBED = 'added and unsubscribed'

          # All values
          ALL = [UNSUBSCRIBED, WAS_INACTIVE, WAS_UNSUBSCRIBED, ADDED_AND_UNSUBSCRIBED].freeze
        end
      end
    end
  end
end
