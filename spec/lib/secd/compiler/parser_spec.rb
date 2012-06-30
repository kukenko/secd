#coding: utf-8
require 'spec_helper'

module Secd
  module Compiler
    describe Parser do
      let(:parser) { Parser.new }

      describe '#parse' do
        it { parser.parse('1') }
        it { parser.parse('(1)') }
        it { parser.parse('(1 2)') }
        it { parser.parse('(+ 1 2)') }
        it { parser.parse('(+ 1 (+ 2 3))') }
        it { parser.parse('(- 3 (+ 2 1))') }
      end

    end
  end
end
