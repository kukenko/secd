#coding: utf-8

require 'parslet'

module Secd
  module Compiler
    class Transformer < Parslet::Transform
      rule(:int => simple(:int)) { Ldc.new(int) }
    end

    class Ldc < Struct.new(:int)
      def eval
        [:ldc, int.to_i]
      end
    end
  end
end

