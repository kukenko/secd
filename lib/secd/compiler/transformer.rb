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
    end

    class List < Struct.new(:elements)
      def eval
        car = elements.shift
        cdr = elements
        [cdr.map { |elem| elem.eval }, car.eval].flatten
      end
    end

    class Sym < Struct.new(:sym)
      def eval
        case sym
          when '+' then :add
          when '-' then :sub
        end
      end
    end
  end
end
