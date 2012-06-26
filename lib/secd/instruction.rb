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
      @stack << @stack.pop + @stack.pop
    end

    def sub
      @stack << (-@stack.pop) + @stack.pop
    end
    
    def ld
      index = next_code
      @stack << @environment[index[0]][index[1]]
    end

    def sel
      if_clause   = next_code
      else_clause = next_code
      @dump << @code
      @code = @stack.pop ? if_clause : else_clause
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
      car = @stack.pop
      cdr = @stack.pop
      @stack << (cdr ? (cdr << car): ([] << car))
    end

    def ldf
      @stack << [next_code, @environment.dup]
    end

    def ap
      clojure  = @stack.pop
      argument = @stack.pop
      @dump << [@stack.dup, @environment.dup, @code.dup]
      @stack.clear
      @code.clear
      @environment = clojure[1]
      @environment << argument
      @code = clojure[0]
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
  end
end
