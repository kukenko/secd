# -*- coding: utf-8 -*-
require 'secd/instruction'
require_relative 'machine/register'

module SECD
  class Machine
    def initialize
      @s = Register::Stack.new
      @e = Register::Environment.new
      @c = Register::Control.new
      @d = Register::Dump.new
    end
    attr_accessor :s, :e, :c, :d
    
    def boot
      SECD.const_set :MIL, Instruction.new(proc_nil)
      SECD.const_set :LDC, Instruction.new(proc_ldc)
      SECD.const_set :LD,  Instruction.new(proc_ld)
      SECD.const_set :ADD, Instruction.new(proc_add)
      SECD.const_set :MLT, Instruction.new(proc_multi)
      SECD.const_set :CAR, Instruction.new(proc_car)
      SECD.const_set :ATM, Instruction.new(proc_atom)
      SECD.const_set :SEL, Instruction.new(proc_sel)
      SECD.const_set :JOI, Instruction.new(proc_join)
      SECD.const_set :CON, Instruction.new(proc_cons)
    end

    def reboot
      @s.clear
    end

    def run
      loop do
        break if @c.empty?
        instruction = @c.pop
        instruction.apply if instruction.is_a? Instruction
      end
    end

    private

    def proc_nil
      Proc.new { @s.push nil }
    end

    def proc_ldc
      Proc.new { @s.push @c.pop }
    end

    def proc_ld
      Proc.new do
        @index = @c.pop
        @s.push @e[@index.first][@index.last]
      end
    end

    def proc_add
      Proc.new { @s.push(@s.pop + @s.pop) }
    end

    def proc_multi
      Proc.new { @s.push(@s.pop * @s.pop) }
    end

    def proc_car
      Proc.new do
        car = @s.pop
        @s.push car.first
      end
    end

    def proc_atom
      Proc.new do
        @s.push true unless (@s.pop).is_a? Array
      end
    end

    def proc_sel
      Proc.new do
        condition = @s.pop
        consequent = @c.pop
        alternative = @c.pop
        @d = @c.dup
        @c = condition ? consequent : alternative
      end
    end
    
    def proc_join
      Proc.new do
        @c = @d
      end
    end

    def proc_cons
      Proc.new do
        o1 = @s.pop
        o2 = @s.pop
        @s.push(o2.nil? ? [o1] : o2.unshift(o1))
      end
    end
  end
end
