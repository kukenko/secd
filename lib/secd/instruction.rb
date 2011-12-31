# -*- coding: utf-8 -*-
module Secd
  class InstructionError < StandardError; end

  class Instruction
    def initialize(context)
      @context = context
    end

    def apply
      raise InstructionError
    end
  end
end
