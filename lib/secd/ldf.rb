# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ldf < Instruction
    def call
      code = @context.control.shift
      @context.push [code, @context.environment.dup]
    end
  end
end
