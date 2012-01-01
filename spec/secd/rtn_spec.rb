# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Rtn do
    let(:ctx) { Context.new }

    it "スタックからリターン値をポップし、ダンプからS、E、Cをリストアする" do
      vm = Vm.new(ctx)
      ctx.dump[:s] = [Secd::Ld.new, [1, 2]]
      ctx.dump[:e] = [[1], [2, 3, 4], [5], [6, 7]]
      ctx.dump[:c] = [Secd::Ldc.new, 3]
      ctx.push 10
      vm.store [Secd::Rtn.new]
      vm.run
      vm.stop.should eq(3)      
    end
  end
end
