require('oxide/value')
require('oxide/values/floating_point')

module Oxide
  module Values
    class Integer < Value
      attr_reader :integer

      def initialize(integer)
        super(:integer)
        @integer = integer
      end

      def +(operand)
        case operand.type
        when :integer
          Oxide::Values::Integer.new(integer + operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer + operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def -(operand)
        case operand.type
        when :integer
          Oxide::Values::Integer.new(integer - operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer - operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def *(operand)
        case operand.type
        when :integer
          Oxide::Values::Integer.new(integer * operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer * operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def /(operand)
        case operand.type
        when :integer
          Oxide::Values::Integer.new(integer / operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer / operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def %(operand)
        case operand.type
        when :integer
          Oxide::Values::Integer.new(integer % operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer % operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def to_s
        integer.to_s
      end
    end
  end
end
