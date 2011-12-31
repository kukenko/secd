# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ldc < Instruction
    def apply
      arg = @context.control.shift
      @context.stack.push arg
    end
  end
end
