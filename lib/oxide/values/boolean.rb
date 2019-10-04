require('oxide/value')

module Oxide
  module Values
    class Boolean < Value
      attr_reader :boolean

      def initialize(boolean)
        super(:boolean)
        @boolean = boolean
      end

      def or(other)
        case other.type
        when :boolean
          Oxide::Values::Boolean.new(boolean || other.boolean)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def and(other)
        case other.type
        when :boolean
          Oxide::Values::Boolean.new(boolean && other.boolean)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def ==(other)
        case other.type
        when :boolean
          Oxide::Values::Boolean.new(boolean == other.boolean)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def !=(other)
        case other.type
        when :boolean
          Oxide::Values::Boolean.new(boolean != other.boolean)
        else
          raise(ArgumentError, "invalid operand type: #{other.type.to_json}")
        end
      end

      def to_s
        boolean.to_s
      end
    end
  end
end
