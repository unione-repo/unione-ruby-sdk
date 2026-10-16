# frozen_string_literal: true

module UniOne
  module Api
    module Template
      module Model
        # Editor type, "html" or "visual". Default is "html". You can create a template with "visual" editor
        # type only in web interface.
        module EditorType
          HTML = 'html'
          VISUAL = 'visual'

          # All values
          ALL = [HTML, VISUAL].freeze
        end
      end
    end
  end
end
