# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Join do
    before(:all) do
      @ctx = Context.new
      @ctx.control.unshift 3
      @ctx.control.unshift Secd::Ldc.new(@ctx)
      @ctx.dump.unshift @ctx.control.dup
      @ctx.control.clear
      @ctx.control.unshift Secd::Join.new(@ctx)      
    end

    it "ダンプからリスト参照をポップしそれをCレジスタにセットする。" do
      vm = Vm.new(@ctx)
      vm.run
      vm.stop.should eq(3)
    end
  end
end
