require('oxide/value')

module Oxide
  module Values
    class Boolean < Value
      attr_reader :boolean

      def initialize(boolean)
        super(:boolean)
        @boolean = boolean
      end

      def or(operand)
        case operand.type
        when :boolean
          Oxide::Values::Boolean.new(boolean || operand.boolean)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def and(operand)
        case operand.type
        when :boolean
          Oxide::Values::Boolean.new(boolean && operand.boolean)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def ==(operand)
        case operand.type
        when :boolean
          Oxide::Values::Boolean.new(boolean == operand.boolean)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def !=(operand)
        case operand.type
        when :boolean
          Oxide::Values::Boolean.new(boolean != operand.boolean)
        else
          raise("invalid operand type: #{operand.type.to_json}")
        end
      end

      def to_s
        boolean.to_s
      end
    end
  end
end
