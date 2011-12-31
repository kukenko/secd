# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Ldc do
    let(:ctx) { Context.new }

    it "定数をスタックにプッシュする" do
      vm = Vm.new(ctx)
      vm.load(Secd::Ldc.new(ctx), 3)
      vm.run
      vm.stop.should eq(3)
    end
  end
end