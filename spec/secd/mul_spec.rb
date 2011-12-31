# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Mul do
    before(:all) do
      @ctx = Context.new
      @ctx.control.unshift(Secd::Mul.new(@ctx), 3, 9)
    end

    it "乗算の結果をスタックにプッシュする" do
      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(27)
    end
  end
end
