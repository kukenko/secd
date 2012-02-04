# coding: utf-8
require 'spec_helper'

module Secd
  describe Add do
    let(:ctx) { Context.new }

    it "加算の結果をスタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.store [Secd::Ldc.new, 3]
      vm.store [Secd::Ldc.new, 4]
      vm.store [Secd::Add.new]
      vm.run
      vm.stop.should eq(7)
    end
  end
end
