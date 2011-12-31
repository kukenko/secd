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
        if instruction.is_a? Secd::Instruction
          instruction.apply(@context)
          instruction.call
        end
      end
    end

    def store(*instructions)
      @context.push_to_control(instructions)
    end

    def stop
      @context.pop
    end
  end
end
