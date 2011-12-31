# -*- coding: utf-8 -*-

module Secd
  class Context
    def initialize
      @stack = Array.new
      @environment = Array.new
      @control = Array.new
      @dump = Array.new
    end
    attr_accessor :stack, :environment, :control, :dump
  end
end
