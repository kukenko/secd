# -*- coding: utf-8 -*-

module SECD
  class Instruction
    def initialize(spec)
      @spec = spec
    end

    def apply
      @spec.call
    end
  end
end
