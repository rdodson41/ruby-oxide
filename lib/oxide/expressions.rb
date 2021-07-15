# frozen_string_literal: true

module Oxide
  module Expressions
    class False; end
    class True; end

    BasicAssignment = Struct.new(:left, :right)
    AdditionAssignment = Struct.new(:left, :right)
    SubtractionAssignment = Struct.new(:left, :right)
    MultiplicationAssignment = Struct.new(:left, :right)
    DivisionAssignment = Struct.new(:left, :right)
    ModuloAssignment = Struct.new(:left, :right)
    LogicalOr = Struct.new(:left, :right)
    LogicalAnd = Struct.new(:left, :right)
    EqualTo = Struct.new(:left, :right)
    NotEqualTo = Struct.new(:left, :right)
    LessThan = Struct.new(:left, :right)
    LessThanOrEqualTo = Struct.new(:left, :right)
    GreaterThan = Struct.new(:left, :right)
    GreaterThanOrEqualTo = Struct.new(:left, :right)
    Pipe = Struct.new(:left, :right)
    Application = Struct.new(:left, :right)
    Addition = Struct.new(:left, :right)
    Subtraction = Struct.new(:left, :right)
    Multiplication = Struct.new(:left, :right)
    Division = Struct.new(:left, :right)
    Modulo = Struct.new(:left, :right)
    UnaryAddition = Struct.new(:right)
    UnarySubtraction = Struct.new(:right)
    LogicalNot = Struct.new(:right)
    PostfixIncrement = Struct.new(:left)
    PostfixDecrement = Struct.new(:left)
    PrefixIncrement = Struct.new(:right)
    PrefixDecrement = Struct.new(:right)
    Integer = Struct.new(:integer)
    FloatingPoint = Struct.new(:floating_point)
    Identifier = Struct.new(:identifier)
  end
end
