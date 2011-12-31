# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ld < Instruction
    def apply
      arg = @context.control.shift
      @context.stack.unshift @context.environment[arg.first][arg.last]
    end
  end
end
