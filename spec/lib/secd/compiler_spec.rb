#coding: utf-8
require 'spec_helper'

module Secd
  describe Compiler do

    describe '#compile' do
      context "with '1'" do
        let(:code) { Compiler.compile('1') }
        it { code.should eq([:ldc, 1])}
      end

      context "with '(1)'" do
        let(:code) { Compiler.compile('(1)') }
        it { code.should eq([:ldc, 1])}
      end

      context "with '(+ 1 2)'" do
        let(:code) { Compiler.compile('(+ 1 2)') }
        it do
          code.should eq([:ldc, 1, :ldc, 2, :add])
        end
      end

      context "with '(- 3 (+ 2 1))'" do
        let(:code) { Compiler.compile('(- 3 (+ 2 1))') }
        it do
          code.should eq([:ldc, 3, :ldc, 2, :ldc, 1, :add, :sub])
        end
      end

      context "with '(if (atom 5) 9 7)'" do
        let(:code) { Compiler.compile('(if (atom 5) 9 7)') }
        it do
          code.should eq([:ldc, 5, :atom, :sel, [:ldc, 9, :join], [:ldc, 7, :join]])
        end
      end
    end

  end
end
