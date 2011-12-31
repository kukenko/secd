# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Sel do
    let(:ctx) { Context.new }
    
    it "スタックからポップして真の場合に先頭のリストを実行する" do
      ctx.stack.unshift true

      vm = Vm.new(ctx)
      vm.load(Secd::Sel.new)
      vm.load([Secd::Ldc.new, 7])
      vm.load([Secd::Ldc.new, 9])
      vm.run
      vm.stop.should eq(7)
    end

    it "スタックからポップして偽の場合に2番目のリストを実行する" do
      ctx.stack.unshift false

      vm = Vm.new(ctx)
      vm.load(Secd::Sel.new)
      vm.load([Secd::Ldc.new, 7])
      vm.load([Secd::Ldc.new, 9])
      vm.run
      vm.stop.should eq(9)
    end
  end
end
