# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Instruction do
    let(:ins) { Instruction.new("") }

    it "applyは呼びだすと例外が起きる" do
      lambda { ins.apply }.should raise_error(Secd::InstructionError)
    end
  end
end
