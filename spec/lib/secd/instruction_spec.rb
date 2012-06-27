# -*- coding: utf-8 -*-
require 'spec_helper'

module Secd
  describe Instruction do
    before do
      @secd = SecdMock.new
    end

    describe "#nil!" do
      it "push nil to @stack" do
        @secd.nil!
        @secd.result.should be_nil
      end
    end

    describe "#ldc" do
      it "push constant to @stack from @code" do
        @secd.code << 3
        @secd.ldc
        @secd.result.should eq(3)
      end
    end

    describe "#add" do
      it "push sum of constant to @stack" do
        @secd.stack << 1 << 2
        @secd.add
        @secd.result.should eq(3)
      end
    end

    describe "#sub" do
      it "push substruction of constant to @stack" do
        @secd.stack << 2 << 1
        @secd.sub
        @secd.result.should eq(1)
      end
    end

    describe "#ld" do
      it "push variable loaded from environment" do
        @secd.code << [1,1]
        @secd.environment << [1,3] << [4,[5,6]]
        @secd.ld
        @secd.result.should eq([5,6])
      end
    end

    describe "#sel" do
      context "stacked true value" do
        it "push if clause to @code" do
          @secd.stack << true
          @secd.code << [0, :ldc] << [1, :ldc]
          @secd.sel
          @secd.code.should eq([1, :ldc])
        end
      end

      context "stacked false value" do
        it "push else clause to @code" do
          @secd.stack << false
          @secd.code << [0, :ldc] << [1, :ldc]
          @secd.sel
          @secd.code.should eq([0, :ldc])
        end
      end
    end

    describe "#join" do
      it "push code to @dump" do
        @secd.dump << [:ldc, 0]
        @secd.join
        @secd.code.should eq([:ldc, 0])
      end
    end

    describe "#car" do
      it "push car of stack to stack" do
        @secd.stack << [5, 6]
        @secd.car
        @secd.result.should eq(5)
      end
    end

    describe "#atom" do
      context "if stack value is atom" do
        it "push true to stack" do
          @secd.stack << 1
          @secd.atom
          @secd.result.should be_true
        end
      end

      context "if stack value is not atom" do
        it "push false to stack" do
          @secd.stack << [1]
          @secd.atom
          @secd.result.should be_false
        end
      end
    end

    describe "#cons" do
      context "if cdr is nil" do
        it "push pair of object to stack" do
          @secd.stack << nil << 3
          @secd.cons
          @secd.result.should eq([3])
        end
      end

      context "if cdr is not nil" do
        it "push pair of object to stack" do
          @secd.stack << [1] << 3
          @secd.cons
          @secd.result.should eq([1, 3])
        end
      end
    end

    describe "#ldf" do
      let(:closure) { Struct.new(:code, :env).new(:body, :env) }
      it "push closure to stack" do
        @secd.code << :body
        @secd.ldf
        @secd.result.should respond_to(:code)
        @secd.result.should respond_to(:env)
      end
    end

    describe "#ap" do
      let(:closure) { Struct.new(:code, :env).new(:body, []) }
      it "set arguments as environment" do
        @secd.stack << [:args] << closure
        @secd.ap
        @secd.environment.should eq([[:args]])
      end

      it "clear stack" do
        @secd.stack << [:args] << closure
        @secd.ap
        @secd.result.should be_nil
      end

      it "push function to code" do
        @secd.stack << [:args] << closure
        @secd.ap
        @secd.code.should eq(:body)
      end

      it "save S E C to dump" do
        @secd.stack << :s << [:args] << closure
        @secd.environment << :e
        @secd.code << :c
        @secd.ap
        @secd.dump.should eq([[[:s], [:e], [:c]]])
      end
    end

    describe "#rtn" do
      it "restore S from dump and push return value" do
        @secd.stack << 1
        @secd.dump << [[:s], [:e], [:c]]
        @secd.rtn
        @secd.stack.should eq([:s, 1])
      end

      it "restore E from dump" do
        @secd.dump << [[:s], [:e], [:c]]
        @secd.rtn
        @secd.environment.should eq([:e])
      end

      it "restore C from dump" do
        @secd.dump << [[:s], [:e], [:c]]
        @secd.rtn
        @secd.code.should eq([:c])
      end
    end
  end

  class SecdMock
    include Instruction

    def initialize
      @stack = Stack.new
      @environment = Stack.new
      @code = Stack.new
      @dump = Stack.new
    end
    attr_accessor :stack, :environment, :code, :dump

    def result
      @stack.first
    end

    class Stack < Array
    end
  end
end
