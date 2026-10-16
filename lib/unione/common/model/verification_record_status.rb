# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # Only domains with "confirmed" verification record are allowed as sender domains.
      module VerificationRecordStatus
        CONFIRMED = 'confirmed'
        UNCONFIRMED = 'unconfirmed'

        # All values
        ALL = [CONFIRMED, UNCONFIRMED].freeze
      end
    end
  end
end
