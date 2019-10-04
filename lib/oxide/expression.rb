require('oxide/values/boolean')
require('oxide/values/floating_point')
require('oxide/values/function')
require('oxide/values/integer')

# rubocop:disable Metrics/ClassLength
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

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    def evaluate(context)
      case type
      when 'or'
        evaluate_left(context).or(evaluate_right(context))
      when 'and'
        evaluate_left(context).and(evaluate_right(context))
      when 'equal'
        evaluate_left(context) == evaluate_right(context)
      when 'not_equal'
        evaluate_left(context) != evaluate_right(context)
      when 'less_than'
        evaluate_left(context) < evaluate_right(context)
      when 'less_than_or_equal'
        evaluate_left(context) <= evaluate_right(context)
      when 'greater_than'
        evaluate_left(context) > evaluate_right(context)
      when 'greater_than_or_equal'
        evaluate_left(context) >= evaluate_right(context)
      when 'pipe'
        evaluate_right(context).evaluate(evaluate_left(context))
      when 'application'
        evaluate_left(context).evaluate(evaluate_right(context))
      when 'addition'
        evaluate_left(context) + evaluate_right(context)
      when 'subtraction'
        evaluate_left(context) - evaluate_right(context)
      when 'multiplication'
        evaluate_left(context) * evaluate_right(context)
      when 'division'
        evaluate_left(context) / evaluate_right(context)
      when 'modulo'
        evaluate_left(context) % evaluate_right(context)
      when 'expressions'
        evaluate_expressions(context).last
      when 'false'
        Oxide::Values::Boolean.new(false)
      when 'true'
        Oxide::Values::Boolean.new(true)
      when 'integer'
        Oxide::Values::Integer.new(integer)
      when 'floating_point'
        Oxide::Values::FloatingPoint.new(floating_point)
      when 'identifier'
        context.fetch(identifier)
      when 'assignment'
        context[identifier] = evaluate_right(context)
      when 'addition_assignment'
        context[identifier] =
          context.fetch(identifier) + evaluate_right(context)
      when 'subtraction_assignment'
        context[identifier] =
          context.fetch(identifier) - evaluate_right(context)
      when 'multiplication_assignment'
        context[identifier] =
          context.fetch(identifier) * evaluate_right(context)
      when 'division_assignment'
        context[identifier] =
          context.fetch(identifier) / evaluate_right(context)
      when 'modulo_assignment'
        context[identifier] =
          context.fetch(identifier) % evaluate_right(context)
      when 'function'
        Oxide::Values::Function.new(identifier, right, context)
      else
        raise(ArgumentError, "invalid expression type: #{type.to_json}")
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength

    def evaluate_left(context)
      Oxide::Expression.evaluate(left, context)
    end

    def evaluate_right(context)
      Oxide::Expression.evaluate(right, context)
    end

    def evaluate_expressions(context)
      expressions.map do |expression|
        Oxide::Expression.evaluate(expression, context)
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
# rubocop:enable Metrics/ClassLength
