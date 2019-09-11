require('oxide/expression')
require('oxide/value')

require('pry')

module Oxide
  module Values
    class Function < Value
      attr_reader :identifier
      attr_reader :right
      attr_reader :context

      def initialize(identifier, right, context)
        super(:function)
        @identifier = identifier
        @right = right
        @context = context
      end

      def evaluate(argument)
        sub_context = context.merge(identifier => argument)
        Oxide::Expression.evaluate(right, sub_context)
      end

      def to_s
        "#{identifier.to_s} -> #{right.to_json}"
      end
    end
  end
end
