require('oxide/value')

# rubocop:disable Metrics/ClassLength
module Oxide
  module Values
    class FloatingPoint < Value
      attr_reader :floating_point

      def initialize(floating_point)
        super(:floating_point)
        @floating_point = floating_point
      end

      def ==(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point == other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point == other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def !=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point != other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point != other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def <(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point < other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point < other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def <=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point <= other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point <= other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def >(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point > other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point > other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def >=(other)
        case other.type
        when :integer
          Oxide::Values::Boolean.new(floating_point >= other.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point >= other.floating_point)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def +(other)
        case other.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point + other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(
            floating_point + other.floating_point
          )
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def -(other)
        case other.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point - other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(
            floating_point - other.floating_point
          )
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def *(other)
        case other.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point * other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(
            floating_point * other.floating_point
          )
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def /(other)
        case other.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point / other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(
            floating_point / other.floating_point
          )
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def %(other)
        case other.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point % other.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(
            floating_point % other.floating_point
          )
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def to_s
        floating_point.to_s
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
