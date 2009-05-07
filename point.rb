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

module Inox
  
  # Representation of a Point, defined as Object for the ability to 
  # handle it in a good OO manner and furthur extention and
  # modification.
  # 
  # Struct is the base class of Point and as such Point inherits 
  # the already powerful methods of Struct. 
  #
  # The assignment checks for Numeric kind of values 
  # to prevent errors. 
  class Point <  Struct.new(:x, :y)
    
    # added type check to enforce Numeric values
    def initialize(*args)
      super(*(args.empty? ? [0,0] : args))
      unless self.x.kind_of? Numeric and self.y.kind_of? Numeric
        self.x = 0
        self.y = 0
        raise "#{args} not a two Numeric values"
      end
    end

    # added type check to enforce Numeric values    
    def x=(value)
      raise "#{num} not a Numeric value" unless value.kind_of? Numeric
      super(value)
    end
    
    # added type check to enforce Numeric values
    def y=(value)
      raise "#{num} not a Numeric value" unless value.kind_of? Numeric
      super(value)
    end

    def to_hash
      {:x => self.x, :y => self.y}
    end
    
    def to_point
      self
    end
  end
end

# Extending the ability of Array to handle
# extra Inox types
class Array
  
  # Cast an Array holding two Numerics to an instance of the class Point
  #
  # [1,3].to_point  ==  Point.new(1,3)
  def to_point
    raise "Cannot convert #{self} to Point" unless length == 2
    Inox::Point.new(self[0], self[1])
  end
end

# Extending the ability of the Hash class to handle
# extra Inox types
class Hash
  
  # Cast a Hash containing two keys [:x, :y] with Numeric values
  # to an instance of the class Point
  #
  # {:x => 1, y => 3}.to_point  == Point.new(1,3)
  #
  # Extra keys in the hash doesn't interfer
  def to_point
    raise "Cannot find keys 'x' and 'y'" unless key?(:x) and key?(:y) 
    Inox::Point.new(self[:x], self[:y])
  end
end
