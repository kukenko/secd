# coding: utf-8
require 'secd/instruction'

module Secd
  class Ap < Instruction
    def call
      code, env, args = @context.stack
      @context.save(:s)
      @context.save(:e)
      @context.save(:c)
      @context.stack = Array.new
      @context.environment = (env.unshift args)
      @context.control = code
    end
  end
end
