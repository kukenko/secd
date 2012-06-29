#coding: utf-8

require 'parslet'

module Secd
  module Compiler
    class Transformer < Parslet::Transform
      rule(:int => simple(:int))   { Ldc.new(int) }
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
        car.eval
      end
    end
  end
end

