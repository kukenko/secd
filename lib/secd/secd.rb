#coding: utf-8

require_relative 'instruction'

module Secd
  class Secd
    include Instruction

    def initialize
      @stack = Stack.new
      @environment = Stack.new
      @code = Stack.new
      @dump = Stack.new
    end

    def store(instruction)
      # we need deep reverse
      @code = instruction.map { |v| v.is_a?(Array) ? v.reverse : v }.reverse
    end

    def evaluate
      self.send @code.pop
    end

    def finished?
      @code.empty?
    end

    def result
      @stack.pop
    end

    def refresh!
      @stack = Stack.new
    end
  end

  class Stack < Array
  end
end
