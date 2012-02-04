# coding: utf-8
require 'spec_helper'

module Secd
  describe Mul do
    let(:ctx) { Context.new }

    it "乗算の結果をスタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.store [Secd::Ldc.new, 3]
      vm.store [Secd::Ldc.new, 9]
      vm.store [Secd::Mul.new]
      vm.run
      vm.stop.should eq(27)
    end
  end
end
