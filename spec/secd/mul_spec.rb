# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Mul do
    let(:ctx) { Context.new }

    it "乗算の結果をスタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.load(Secd::Mul.new, 3, 9)
      vm.run
      vm.stop.should eq(27)
    end
  end
end
