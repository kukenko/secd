# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Args < Instruction
    def call
      arity = @context.control.shift
      return if arity.zero?
      @context.push get_args(arity)
    end

    private
    def get_args(arity)
      @context.stack.slice!(0..(arity-1))
    end
  end
end
