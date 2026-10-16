# frozen_string_literal: true

module UniOne
  module Common
    module Model
      # The [template engine](https://docs.unione.io/en/template-engines) for handling the
      # substitutions(merge tags), "simple", "velocity", "liquid" or "none". Default value is "simple".
      module TemplateEngine
        SIMPLE = 'simple'
        VELOCITY = 'velocity'
        LIQUID = 'liquid'
        NONE = 'none'

        # All values
        ALL = [SIMPLE, VELOCITY, LIQUID, NONE].freeze
      end
    end
  end
end
