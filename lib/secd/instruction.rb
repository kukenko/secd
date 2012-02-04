# coding: utf-8
module Secd
  class InstructionError < StandardError; end

  class Instruction
    def initialize
      @context
    end

    def apply(context)
      @context ||= context
    end

    def call
      raise InstructionError
    end
  end
end
