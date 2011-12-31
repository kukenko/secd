# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Context
    def initialize
      @stack = Array.new
      @environment = Array.new
      @control = Array.new
      @dump = Array.new
    end
    attr_accessor :stack, :environment, :control, :dump

    def push_to_control(instructions)
      instructions.each do |ins|
        @control.push ins
      end
    end
  end
end
