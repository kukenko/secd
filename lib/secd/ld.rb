# -*- coding: utf-8 -*-
require 'secd/instruction'

module Secd
  class Ld < Instruction
    def call
      arg = @context.control.shift
      @context.push @context.environment[arg.first][arg.last]
    end
  end
end
