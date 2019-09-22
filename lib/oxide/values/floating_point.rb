require('oxide/value')

module Oxide
  module Values
    class FloatingPoint < Value
      attr_reader :floating_point

      def initialize(floating_point)
        super(:floating_point)
        @floating_point = floating_point
      end

      def ==(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point == operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point == operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def !=(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point != operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point != operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def <(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point < operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point < operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def <=(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point <= operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point <= operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def >(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point > operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point > operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def >=(operand)
        case operand.type
        when :integer
          Oxide::Values::Boolean.new(floating_point >= operand.integer)
        when :floating_point
          Oxide::Values::Boolean.new(floating_point >= operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def +(operand)
        case operand.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point + operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(floating_point + operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def -(operand)
        case operand.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point - operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(floating_point - operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def *(operand)
        case operand.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point * operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(floating_point * operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def /(operand)
        case operand.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point / operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(floating_point / operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def %(operand)
        case operand.type
        when :integer
          Oxide::Values::FloatingPoint.new(floating_point % operand.integer)
        when :floating_point
          Oxide::Values::FloatingPoint.new(floating_point % operand.floating_point)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def to_s
        floating_point.to_s
      end
    end
  end
end
