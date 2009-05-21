#--
# Copyright © 2009 William Wolf
# Find documentation at <http://www.ironicwolf.com>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#  
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#  
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require 'pp'

module Inox
  class Assert
    alias __class__ class
    
    
    # if strange assert behavior add the offending method
    # to the list to Not Undefine list
    __nu = "__id__:__send__:instance_eval".split(':')
    Object.new.methods.each { |m|       
      undef_method m  unless __nu.include?(m) 
    }
    
    def initialize(obj)
      @origin = obj
      @obj = @origin    
      @result = true
      @op = :and
    end

    def result
      @result
    end


    def or(*obj, &block)
      @obj = obj[0] unless obj.empty?
      @op = :or 
      eval_block(@obj, &block) unless block.nil?
      self
    end

    def and(*obj, &block)
      @obj = obj[0] unless obj.empty?
      @op = :and
      eval_block(@obj, &block) unless block.nil?
      self
    end

    def not
      @op = case @op
      when :and then :not_and
      when :or then :not_or
      when :not_and then :and
      when :not_or then :or
      end
      self
    end

    def end(should_raise = true, &block)
      if @result == false
        if block.nil? 
          raise StandardError, "Assertions failed", caller(0) if  should_raise
        else
          block.call(self)
        end
      end      
    end

    def push_result(v)
      if v.kind_of?(TrueClass) or v.kind_of?(FalseClass)
        @result = case @op
        when :and then @result and v
        when :or then @result or v
        when :not_and then self.not; @result and !v
        when :not_or then self.not; @result or !v
        end
        @obj = @origin
      else
        @obj = v
      end
      self
    end
    
    def eval_block(ob, &block)
      unless block.nil?
        local_assert = Inox::Assert.new(ob)
        local_assert.instance_eval(&block)
        push_result(local_assert.result)
      end
    end

    def _(&block); eval_block(@obj, &block); end
    
    def each(&block)
      raise "Method missing each" unless @obj.respond_to?(:each)

      @obj.each { |e| eval_block(e, &block) }
      self
    end
    
    def let(sym, &block)
      self.__class__.class_eval do
        define_method(sym) { eval_block(@obj, &block) }
      end
      
      self
    end   
    
    def method_missing(m, *args, &block)
      if @obj.respond_to?(m) 
        push_result @obj.send(m, *args, &block)
      else
        raise "Method missing #{m}"
      end
      self
    end
  end

end #inox

def assert2(obj, &block)
  if block.nil?
    return Inox::Assert.new(obj)
  else
    return Inox::Assert.new(obj)._(&block)
  end
end