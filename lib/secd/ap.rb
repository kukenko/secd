# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ap < Instruction
    def apply
      code, env, args = @context.stack
      @context.dump = [@context.stack.dup, @context.environment.dup, @context.control.dup]
      @context.stack = Array.new
      @context.environment = (env.unshift args)
      @context.control = code
    end
  end
end
