require('oxide/values/floating_point')
require('oxide/values/function')
require('oxide/values/integer')

module Oxide
  class Expression
    class << self
      def evaluate(attributes, context)
        new(attributes).evaluate(context)
      end
    end

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def evaluate(context)
      case type
      when 'pipe'
        Oxide::Expression.evaluate(right, context).evaluate(Oxide::Expression.evaluate(left, context))
      when 'application'
        Oxide::Expression.evaluate(left, context).evaluate(Oxide::Expression.evaluate(right, context))
      when 'addition'
        Oxide::Expression.evaluate(left, context) + Oxide::Expression.evaluate(right, context)
      when 'subtraction'
        Oxide::Expression.evaluate(left, context) - Oxide::Expression.evaluate(right, context)
      when 'multiplication'
        Oxide::Expression.evaluate(left, context) * Oxide::Expression.evaluate(right, context)
      when 'division'
        Oxide::Expression.evaluate(left, context) / Oxide::Expression.evaluate(right, context)
      when 'expressions'
        expressions.map do |expression|
          Oxide::Expression.evaluate(expression, context)
        end.last
      when 'integer'
        Oxide::Values::Integer.new(integer)
      when 'floating_point'
        Oxide::Values::FloatingPoint.new(floating_point)
      when 'identifier'
        context.fetch(identifier)
      when 'assignment'
        context[identifier] = Oxide::Expression.evaluate(right, context)
      when 'function'
        Oxide::Values::Function.new(identifier, right, context)
      else
        raise("invalid expression type: #{type.to_json}")
      end
    end

    private

    def type
      attributes.fetch('type')
    end

    def left
      attributes.fetch('left')
    end

    def right
      attributes.fetch('right')
    end

    def expressions
      attributes.fetch('expressions')
    end

    def integer
      attributes.fetch('integer')
    end

    def floating_point
      attributes.fetch('floating_point')
    end

    def identifier
      attributes.fetch('identifier')
    end
  end
end
