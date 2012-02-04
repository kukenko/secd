# coding: utf-8
require 'secd/Instruction'

module Secd
  class Rtn < Instruction
    def call
      result = @context.pop
      @context.load(:s)
      @context.load(:e)
      @context.load(:c)
      @context.push result
      @context.dump.clear
    end
  end
end
