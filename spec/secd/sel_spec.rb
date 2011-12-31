# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Sel do
    before(:all) do
      @ctx = Context.new
    end
    
    it "スタックからポップして真の場合に先頭のリストを実行する" do
      @ctx.stack.unshift true
      @ctx.control.unshift([Secd::Ldc.new(@ctx), 9])
      @ctx.control.unshift([Secd::Ldc.new(@ctx), 7])
      @ctx.control.unshift Secd::Sel.new(@ctx)

      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(7)
    end

    it "スタックからポップして偽の場合に2番目のリストを実行する" do
      @ctx.stack.unshift false
      @ctx.control.unshift([Secd::Ldc.new(@ctx), 9])
      @ctx.control.unshift([Secd::Ldc.new(@ctx), 7])
      @ctx.control.unshift Secd::Sel.new(@ctx)

      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(9)
    end
  end
end
