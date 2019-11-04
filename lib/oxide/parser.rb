# frozen_string_literal: true

require('oxide/parser.bundle')

module Oxide
  class Parser
    attr_reader :input

    def initialize(input)
      @input = input
    end
  end
end
