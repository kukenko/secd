# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Sel < Instruction
    def call
      t_clause, f_clause = @context.control

      @context.dump.unshift @context.control.dup

      if @context.stack.shift
        @context.control = t_clause
      else
        @context.control = f_clause
      end
    end
  end
end
