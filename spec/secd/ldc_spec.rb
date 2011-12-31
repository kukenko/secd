# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Ldc do
    before(:all) do
      @ctx = Context.new
      @ctx.control.unshift(Secd::Ldc.new(@ctx), 3)
    end

    it "定数をスタックにプッシュする" do
      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(3)
    end
  end
end
