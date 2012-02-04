# coding: utf-8
require 'secd/instruction'

module Secd
  class Ldf < Instruction
    def call
      @context.push @context.environment.dup
      @context.push @context.control.shift
    end
  end
end
