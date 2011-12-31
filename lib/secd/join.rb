# -*- coding: utf-8 -*-
require 'secd/Instruction'

module Secd
  class Join < Instruction
    def call
      @context.control = @context.dump.shift
    end
  end
end
