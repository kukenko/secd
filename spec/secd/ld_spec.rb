# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Ld do
    before(:all) do
      @ctx = Context.new
      @ctx.environment.unshift([1], [2, 3, 4], [5], [6, 7])
      @ctx.control.unshift(Secd::Ld.new(@ctx), [1, 2])
    end

    it "変数の値をスタックにプッシュする" do
      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(4)
    end
  end
end
