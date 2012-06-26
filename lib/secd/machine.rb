#coding: utf-8

module Secd
  class Machine

    def initialize
      @secd = Secd.new
    end

    def run
      loop do
        break if @secd.finished?
        @secd.evaluate
      end
      @secd.result
    end

    def load(instruction)
      @secd.store instruction
    end

    def reboot!
      @secd.refresh!
    end

  end
end

require_relative 'secd'
