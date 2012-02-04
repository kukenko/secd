# coding: utf-8
require 'spec_helper'

module Secd
  describe Ldf do
    let(:ctx) { Context.new }
    
    it "クロージャを構築し、スタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.store [Secd::Ldc.new, 2, Secd::Ldc.new, 5]
      vm.store [Secd::Args.new, 2]
      code = [Secd::Ld.new, [0, 1], Secd::Ld.new, [0, 0], Secd::Add.new, Secd::Rtn.new]
      vm.store [Secd::Ldf.new, code, Secd::Ap.new]
      vm.run
      vm.stop.should eq(7)
    end
  end
end
