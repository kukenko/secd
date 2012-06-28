#coding: utf-8

module Secd
  module Compiler
    def self.compile(code)
      @parser      ||= Parser.new
      @transformer ||= Transformer.new

      ast = @transformer.apply(@parser.parse(code))
      ast.eval
    end
  end
end

require_relative 'compiler/parser'
require_relative 'compiler/transformer'
