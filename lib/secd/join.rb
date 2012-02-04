# coding: utf-8
require 'secd/Instruction'

module Secd
  class Join < Instruction
    def call
      @context.load(:c)
    end
  end
end