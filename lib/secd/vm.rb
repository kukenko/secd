# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Vm
    def initialize(context)
      @context = context
    end

    def run
      loop do
        break if @context.control.empty?
        instruction = @context.control.shift
        instruction.apply if instruction.is_a? Secd::Instruction
      end
    end

    def stop
      @context.stack.pop
    end
  end
end
