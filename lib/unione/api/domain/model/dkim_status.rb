# frozen_string_literal: true

module UniOne
  module Api
    module Domain
      module Model
        # Only domains with "active" DKIM record are allowed as sender domains.
        module DkimStatus
          ACTIVE = 'active'
          INACTIVE = 'inactive'

          # All values
          ALL = [ACTIVE, INACTIVE].freeze
        end
      end
    end
  end
end
