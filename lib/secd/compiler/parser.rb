#coding: utf-8

require 'parslet'

module Secd
  module Compiler
    class Parser < Parslet::Parser
      rule(:integer) { match('[0-9]').repeat(1).as(:int) }
      rule(:expr) { integer }
      root :expr
    end
  end
end
