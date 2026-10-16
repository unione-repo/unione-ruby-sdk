# frozen_string_literal: true

module UniOne
  module Api
    module Webhook
      module Model
        # Notification format. "json_post"(default) or "json_post_gzip".
        module WebhookEventFormat
          JSON_POST = 'json_post'
          JSON_POST_GZIP = 'json_post_gzip'

          # All values
          ALL = [JSON_POST, JSON_POST_GZIP].freeze
        end
      end
    end
  end
end
