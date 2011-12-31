# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Join do
    let(:ctx) { Context.new }

    it "ダンプからリスト参照をポップしそれをCレジスタにセットする。" do
      vm = Vm.new(ctx)
      vm.store(Secd::Ldc.new, 3)
      ctx.save(:c)
      ctx.control.clear
      vm.store(Secd::Join.new)
      vm.run
      vm.stop.should eq(3)
    end
  end
end
