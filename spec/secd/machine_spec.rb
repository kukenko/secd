# -*- coding: utf-8 -*-
require 'spec_helper'

module SECD
  describe Machine do
    before(:all) do
      @secd = Machine.new
      @secd.boot
    end
    
    describe "#run" do
      it "MILを評価すると@sにnilがpushされる" do
        @secd.reboot
        @secd.c.push MIL
        @secd.run
        @secd.s.should eq([nil])
      end

      it "LDCを評価すると@sに定数がpushされる" do
        @secd.reboot
        @secd.c.push(3, LDC)
        @secd.run
        @secd.s.should eq([3])
      end

      it "ADDを評価すると@sにある定数を加算できる" do
        @secd.reboot
        @secd.c.push ADD
        @secd.c.push(6, LDC)
        @secd.c.push(2, LDC)
        @secd.run
        @secd.s.should eq([8])        
      end

      it "MLTを評価すると@sにある定数を乗算できる" do
        @secd.reboot
        @secd.c.push MLT
        @secd.c.push ADD
        @secd.c.push(6, LDC)
        @secd.c.push(2, LDC)
        @secd.c.push(3, LDC)
        @secd.run
        @secd.s.should eq([24])        
      end

      it "LDを評価すると@eにある値が@sにpushされる" do
        @secd.reboot
        @secd.e.push([1, 3], [4, [5, 6]])
        @secd.c.push ADD
        @secd.c.push([0, 0], LD)
        @secd.c.push CAR
        @secd.c.push([1, 1], LD)
        @secd.run
        @secd.s.should eq([6])
      end

      it "SELを評価すると評価する対象を選択できる" do
        @secd.reboot
        @secd.c.push [JOI, 7, LDC]
        @secd.c.push [JOI, 9, LDC]
        @secd.c.push SEL
        @secd.c.push ATM
        @secd.c.push(5, LDC)
        @secd.run
        @secd.s.should eq([9])
      end

      it "CONを評価するとペアを作成できる" do
        @secd.reboot
        @secd.c.push CON
        @secd.c.push(2, LDC)
        @secd.c.push CON
        @secd.c.push(3, LDC)
        @secd.c.push MIL
        @secd.run
        @secd.s.should eq([[2, 3]])
      end
    end
  end
end
