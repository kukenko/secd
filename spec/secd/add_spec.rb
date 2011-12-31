# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Add do
    before(:all) do
      @ctx = Context.new
      @ctx.control.unshift(Secd::Add.new(@ctx), 3, 4)
    end

    it "加算の結果をスタックにプッシュする" do
      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(7)
    end
  end
end
