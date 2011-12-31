# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Add do
    let(:ctx) { Context.new }

    it "加算の結果をスタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.load(Secd::Add.new(ctx), 3, 4)
      vm.run
      vm.stop.should eq(7)
    end
  end
end
