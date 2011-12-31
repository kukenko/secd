# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Add < Instruction
    def call
      n1, n2 = @context.control
      @context.push(n1 + n2)
    end
  end
end
