# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Context
    def initialize
      @stack = Array.new
      @environment = Array.new
      @control = Array.new
      @dump = Hash.new
    end
    attr_accessor :stack, :environment, :control, :dump

    def push_to_control(instructions)
      instructions.each do |ins|
        @control.push ins
      end
    end

    def save(register)
      case register
      when :s then @dump[:s] = @stack.dup
      when :e then @dump[:e] = @environment.dup
      when :c then @dump[:c] = @control.dup
      end
    end

    def load(register)
      case register
      when :s then @stack = @dump[:s]
      when :e then @environment = @dump[:e]
      when :c then @control = @dump[:c]
      end
    end

    def push(value)
      @stack.unshift value
    end

    def pop
      @stack.shift
    end
  end
end
