# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # Sets the email counter mode. It allows you to choose whether the counter should reset automatically,
      # or remain permanent. The following values are acceptable: 'default' - the counter resets to zero
      # automatically at the beginning of each accounting period, 'permanent' - the counter never resets
      # automatically. The reset can be done only manually by the user in the request with the passes 0
      # value in the email_counter field. If the request doesn't contain the field or contains a null value,
      # the limit value doesn't change.
      module EmailCounterMode
        DEFAULT = 'default'
        PERMANENT = 'permanent'

        # All values
        ALL = [DEFAULT, PERMANENT].freeze
      end
    end
  end
end
