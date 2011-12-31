# -*- coding: utf-8 -*-
require 'secd/Instruction'

module Secd
  class Rtn < Instruction
    def call
      result = @context.stack.shift
      s, e, c = @context.dump
      @context.stack = s
      @context.environment = e
      @context.control = c
      @context.stack.unshift result
      @context.dump.clear
    end
  end
end
