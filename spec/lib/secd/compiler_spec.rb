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
    end

  end
end
