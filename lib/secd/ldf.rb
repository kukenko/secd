# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ldf < Instruction
    def apply
      code = @context.control.shift
      @context.stack.push(code, @context.environment.dup)
    end
  end
end
