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
require 'core/point'
require 'core/size'

module Inox
  class Rect
    attr_accessor :origin, :size
    
    def initialize(*args)
      @origin = (((o = args[0..1]).nil? ? [] : o).empty? ? [0,0] : o).to_point
      @size = (((s = args[2..3]).nil? ? [] : s).empty? ? [0,0] : s).to_size
    end
    
    def ==(obj)
      if obj.respond_to?(:origin) and obj.respond_to?(:size) then
        return (@origin == obj.origin and @size == obj.size)
      elsif obj.respond_to?(:to_rect) then
        return self == obj.to_rect
      else
        return false
      end
    end
      
    def origin=(o)
      if o.respond_to?(:to_point) then
        @origin = o.to_point
      else
        raise "Cannot assing #{o} to origin kind_of? Point expected"
      end
    end
    
    def size=(s)
      if s.respond_to?(:to_size) then
        @size = o.to_size
      else
        raise "Cannot assing #{s} to size kind_of? Size expected"
      end
    end
    
    def to_a
      [@origin.x, @origin.y, @size.width, @size.height]
    end
    
    def to_rect
      self
    end
    
    def left
      self.origin.x
    end

    def left=(i)
      self.origin.x = i
    end

    def right
      self.origin.x + self.size.width
    end

    def right=(i)
      self.origin.x = i - self.size.width
    end

    def top
      self.origin.y
    end

    def top=(i)
      self.origin.y = i
    end

    def bottom
      self.origin.y + self.size.height
    end

    def bottom=(i)
      self.origin.y = i - self.size.height
    end
    
    def center
      cx = self.origin.x + (self.size.width / 2)
      cy = self.origin.y + (self.size.height / 2)
      return [cx, cy].to_point 
    end
    
    def center=(obj)
      p = obj.to_point
      self.origin.x = p.x - (self.size.width/2)
      self.origin.y = p.y - (self.size.height/2)
    end
  end
end


class Array
  def to_rect
    raise "Cannot convert #{self} to Rect" unless length == 4
    Inox::Rect.new(*self)
  end
end    
