# frozen_string_literal: true

module Oxide
  module Expressions
    class False; end
    class True; end

    Integer = Struct.new(:integer)
    FloatingPoint = Struct.new(:floating_point)
    Identifier = Struct.new(:identifier)
    BasicAssignment = Struct.new(:identifier, :right)
    AdditionAssignment = Struct.new(:identifier, :right)
    SubtractionAssignment = Struct.new(:identifier, :right)
    MultiplicationAssignment = Struct.new(:identifier, :right)
    DivisionAssignment = Struct.new(:identifier, :right)
    ModuloAssignment = Struct.new(:identifier, :right)
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
  end
end
