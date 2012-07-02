#coding: utf-8

module Secd
  module Instruction

    def nil!
      @stack << nil
    end

    def ldc
      @stack << next_code
    end

    def add
      @stack << @stack.pop(2).inject(:+)
    end

    def sub
      @stack << @stack.pop(2).inject(:-)
    end

    def ld
      index = next_code
      @stack << @environment[index[0]][index[1]]
    end

    def sel
      else_clause, if_clause = @code.pop(2)
      @dump << @code.dup
      @code = evaluate_true? ? if_clause : else_clause
    end

    def join
      @code = @dump.pop
    end

    def car
      @stack << @stack.pop.first
    end

    def atom
      @stack << (@stack.pop.is_a?(Array) ? false : true)
    end

    def cons
      cdr, car = @stack.pop(2)
      @stack << (cdr ? (cdr << car): ([] << car))
    end

    def ldf
      closure = Struct.new(:code, :env)
      @stack << closure.new(next_code, @environment.dup)
    end

    def ap
      argument, closure = @stack.pop(2)
      @dump << [@stack.dup, @environment.dup, @code.dup]
      @stack.clear
      @code.clear
      @code = closure.code
      @environment = closure.env
      @environment << argument
    end

    def rtn
      val          = @stack.pop
      saved        = @dump.pop
      @stack       = (saved[0] << val)
      @environment = saved[1]
      @code        = saved[2]
    end

    private

    def next_code
      @code.pop
    end

    def evaluate_true?
      @stack.pop
    end
  end
end
