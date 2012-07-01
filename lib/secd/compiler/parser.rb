#coding: utf-8

require 'parslet'

module Secd
  module Compiler
    class Parser < Parslet::Parser
      rule(:space)      { match['\s'].repeat(0) }
      rule(:space?)     { space.maybe }

      rule(:lparen)     { str('(') >> space? }
      rule(:rparen)     { space? >> str(')') }

      rule(:integer)    { match('[0-9]').repeat(1).as(:int) }
      rule(:symbol) do
        head = %r{[a-zA-z!$%&*/:<=>?^_~+-]}
        body = %r{[a-zA-z=*_+-?!]}
        (match(head) >> (integer | match(body)).repeat(0)).as(:sym)
      end

      rule(:arg)        { symbol | integer | list }
      rule(:args)       { (arg >> space?).repeat }
      rule(:list)       { lparen >> args.as(:exp) >> rparen }

      rule(:expression) { integer | list }
      root(:expression)
    end
  end
end
