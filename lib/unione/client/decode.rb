# frozen_string_literal: true

module UniOne
  module Client
    # Lenient decoding of responses for the models: a response that lacks a field, has null in it or a value of
    # another type does not break from_h, the field is nil (a model is built only from a Hash, a list only from an
    # Array).
    module Decode
      module_function

      # klass.from_h(value) for a Hash, nil for anything else.
      def model(klass, value)
        value.is_a?(Hash) ? klass.from_h(value) : nil
      end

      # The array (each item through the block, if given), nil for anything else.
      def list(value, &block)
        return nil unless value.is_a?(Array)

        block ? value.map(&block) : value
      end

      # The hash (each value through the block, if given; [] - an empty object encoded as an array - gives {}),
      # nil for anything else.
      def map(value, &block)
        return {} if value.is_a?(Array) && value.empty?
        return nil unless value.is_a?(Hash)

        block ? value.transform_values(&block) : value
      end
    end
  end
end
