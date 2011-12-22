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

      it "LDFを評価すると@sに@eと一緒に関数本体がにpushされる" do
        @secd.store(LDF, [LD, [1, 2], LD, [1, 1], ADD])
        @secd.run
        should eq([[LD, [1, 2], LD, [1, 1], ADD]])
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

      it "SELを評価すると評価する対象を選択できる" do
        @secd.store(LDC, 5, ATOM, SEL, [LDC, 9, JOIN], [LDC, 7, JOIN])
        @secd.run
        should eq(9)
      end

      it "CONを評価するとペアを作成できる" do
        @secd.store(MIL, LDC, 3, CONS, LDC, 2, CONS)
        @secd.run
        should eq([2, 3])
      end

      it "APを評価すると@sにある関数が適用される" do
        @secd.store(NIL, LDC, 3, CONS, LDC, 2, CONS)
        @secd.store(LDF, [LD, [0, 1], LD, [0, 0], ADD, RTN], AP)
        @secd.run
        should eq(5)
      end
    end
  end
end
