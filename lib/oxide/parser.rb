# frozen_string_literal: true

require('oxide/parser.bundle')

module Oxide
  class Parser
    attr_reader :scanner

    def initialize(scanner)
      @scanner = scanner
    end
  end
end
