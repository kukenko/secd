# coding: utf-8
require "spec_helper"

module Secd
  describe Args do
    let(:ctx) { Context.new }

    it "スタックから指定個数の引数を取り出す" do
      vm = Vm.new(ctx)
      vm.store [Secd::Ldc.new, 3, Secd::Ldc.new, 5, Secd::Ldc.new, 7]
      vm.store [Secd::Args.new, 2]
      vm.run
      vm.stop.should eq([7, 5])
    end
  end
end