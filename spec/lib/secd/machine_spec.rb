#coding: utf-8
require 'spec_helper'

module Secd
  describe Machine do
    let(:machine) { Machine.new }

    describe '#run' do
      context 'with [:nil!]' do
        it 'returns nil' do
          machine.load([:nil!])
          machine.run.should be_nil
        end
      end

      context "with '1'" do
        it 'returns 1' do
          code = Compiler.compile('1')
          machine.load(code)
          machine.run.should eq(1)
        end
      end

      context "with '(+ 1 (+ 2 3))'" do
        it 'returns 6' do
          code = Compiler.compile('(+ 1 (+ 2 3))')
          machine.load(code)
          machine.run.should eq(6)
        end
      end

      context "with '(- 3 (+ 2 1))'" do
        it 'return 0' do
          code = Compiler.compile('(- 3 (+ 2 1))')
          machine.load(code)
          machine.run.should eq(0)
        end
      end

      context 'with [:ld, [1,1], :car, :ld, [0,0], :add]' do
        it 'returns 6' do
          machine.instance_eval do
            @secd.instance_eval do
              @environment << [1,3] << [4,[5,6]]
            end
          end
          machine.load([:ld, [1,1], :car, :ld, [0,0], :add])
          machine.run.should eq(6)
        end
      end

      context "with '(if (atom 5) 9 7)'" do
        it 'return 9' do
          code = Compiler.compile('(if (atom 5) 9 7)')
          machine.load(code)
          machine.run.should eq(9)
        end
      end

      context 'with [:nil!, :ldc, 3, :cons, :ldc, 2, :cons, :ldf, [:ld, [0,1], :ld, [0,0], :add, :rtn], :ap]' do
        it 'returns 5' do
          machine.load([:nil!, :ldc, 3, :cons, :ldc, 2, :cons, :ldf, [:ld, [0,1], :ld, [0,0], :add, :rtn], :ap])
          machine.run.should eq(5)
        end
      end
    end

    after(:each) do
      machine.reboot!
    end
  end
end
