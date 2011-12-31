# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Ld do
    let(:ctx) { Context.new }

    it "変数の値をスタックにプッシュする" do
      vm = Vm.new(ctx)
      ctx.environment.unshift([1], [2, 3, 4], [5], [6, 7])
      vm.load(Secd::Ld.new(ctx), [1, 2])
      vm.run
      vm.stop.should eq(4)
    end
  end
end
