# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Join do
    let(:ctx) { Context.new }

    it "ダンプからリスト参照をポップしそれをCレジスタにセットする。" do
      vm = Vm.new(ctx)
      vm.load(Secd::Ldc.new, 3)
      ctx.dump.unshift ctx.control.dup
      ctx.control.clear
      vm.load(Secd::Join.new)
      vm.run
      vm.stop.should eq(3)
    end
  end
end
