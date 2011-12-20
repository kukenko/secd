# -*- coding: utf-8 -*-
require 'spec_helper'

module SECD
  describe Machine do
    before(:all) do
      @secd = Machine.new
      @secd.boot
    end

    after(:each) { @secd.reboot }

    subject { @secd.data }

    describe "#run" do
      it "MILを評価すると@sにnilがpushされる" do
        @secd.store MIL
        @secd.run
        should eq(nil)
      end

      it "LDCを評価すると@sに定数がpushされる" do
        @secd.store(LDC, 3)
        @secd.run
        should eq(3)
      end

      it "ADDを評価すると@sにある定数を加算できる" do
        @secd.store(LDC, 2, LDC, 6, ADD)
        @secd.run
        should eq(8)        
      end

      it "MLTを評価すると@sにある定数を乗算できる" do
        @secd.store(LDC, 3, LDC, 2, LDC, 6, ADD, MLT)
        @secd.run
        should eq(24)        
      end

      it "LDを評価すると@eにある値が@sにpushされる" do
        @secd.e.unshift([1, 3], [4, [5, 6]])
        @secd.store(LD, [1, 1], CAR, LD, [0, 0], ADD)
        @secd.run
        should eq(6)
      end

      it "SELを評価すると評価する対象を選択できる" do
        @secd.store(LDC, 5, ATM, SEL, [LDC, 9, JOI], [LDC, 7, JOI])
        @secd.run
        should eq(9)
      end

      it "CONを評価するとペアを作成できる" do
        @secd.store(MIL, LDC, 3, CON, LDC, 2, CON)
        @secd.run
        should eq([2, 3])
      end
    end
  end
end
