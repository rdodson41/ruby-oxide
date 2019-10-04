require('oxide/value')
require('oxide/values/floating_point')

# rubocop:disable Metrics/ClassLength
module Oxide
  module Values
    class Integer < Value
      attr_reader :integer

      def initialize(integer)
        super(:integer)
        @integer = integer
      end

      def ==(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer == other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer == other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def !=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer != other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer != other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def <(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer < other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer < other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def <=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer <= other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer <= other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def >(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer > other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer > other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def >=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(integer >= other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(integer >= other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def +(other)
        case other.type
        when :integer
          Oxide::Values::Integer.new(integer + other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer + other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def -(other)
        case other.type
        when :integer
          Oxide::Values::Integer.new(integer - other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer - other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def *(other)
        case other.type
        when :integer
          Oxide::Values::Integer.new(integer * other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer * other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def /(other)
        case other.type
        when :integer
          Oxide::Values::Integer.new(integer / other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer / other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def %(other)
        case other.type
        when :integer
          Oxide::Values::Integer.new(integer % other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(integer % other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def to_s
        integer.to_s
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
