# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Rtn do
    let(:ctx) { Context.new }

    it "スタックからリターン値をポップし、ダンプからS、E、Cをリストアする" do
      vm = Vm.new(ctx)
      ctx.dump.unshift([Secd::Ldc.new(ctx), 3]) # c
      ctx.dump.unshift([[1], [2, 3, 4], [5], [6, 7]]) # e
      ctx.dump.unshift([Secd::Ld.new(ctx), [1, 2]]) # s
      ctx.stack.unshift 10
      vm.load(Secd::Rtn.new(ctx))
      vm.run
      vm.stop.should eq(3)      
    end
  end
end
