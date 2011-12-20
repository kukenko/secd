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
    attr_accessor :e
    
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

    def store(*codes)
      codes.each do |code|
        @c.push code
      end
    end

    def run
      loop do
        break if @c.empty?
        instruction = @c.shift
        instruction.apply if instruction.is_a? Instruction
      end
    end

    def data
      @s.first
    end

    private

    def proc_nil
      Proc.new { @s.unshift nil }
    end

    def proc_ldc
      Proc.new { @s.unshift @c.shift }
    end

    def proc_ld
      Proc.new do
        @index = @c.shift
        @s.unshift @e[@index.first][@index.last]
      end
    end

    def proc_ldf
      Proc.new do
      end
    end

    def proc_add
      Proc.new { @s.unshift(@s.shift + @s.shift) }
    end

    def proc_multi
      Proc.new { @s.unshift(@s.shift * @s.shift) }
    end
    def proc_car
      Proc.new do
        car = @s.shift
        @s.unshift car.first
      end
    end

    def proc_atom
      Proc.new do
        @s.unshift true unless (@s.shift).is_a? Array
      end
    end

    def proc_sel
      Proc.new do
        condition = @s.shift
        consequent = @c.shift
        alternative = @c.shift
        @d = @c.dup
        @c = condition ? consequent : alternative
      end
    end
    
    def proc_join
      Proc.new { @c = @d }
    end

    def proc_cons
      Proc.new do
        o1 = @s.shift
        o2 = @s.shift
        @s.unshift(o2.nil? ? [o1] : o2.unshift(o1))
      end
    end
  end
end
