#coding: utf-8

require 'parslet'

module Secd
  module Compiler
    class Transformer < Parslet::Transform
      rule(:int => simple(:int))   { Ldc.new(int) }
      rule(:sym => simple(:sym))   { Sym.new(sym) }
      rule(:exp => sequence(:exp)) { List.new(exp) }
    end

    class Ldc < Struct.new(:int)
      def eval
        [:ldc, int.to_i]
      end

      def clause
        self.eval << :join
      end
    end

    class List < Struct.new(:elements)
      def eval
        car = elements.shift
        if car.eval == :if
          cond_, if_, else_ = elements
          [*(cond_.eval), :sel, if_.clause, else_.clause]
        else
          cdr = elements
          [cdr.map { |elem| elem.eval }, car.eval].flatten
        end
      end
    end

    class Sym < Struct.new(:sym)
      def eval
        case sym
          when '+'    then :add
          when '-'    then :sub
          when 'atom' then :atom
          when 'if'   then :if
        end
      end
    end
  end
end
