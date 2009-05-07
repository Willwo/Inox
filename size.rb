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
=begin rdoc
Author:: William Wolf
Copyright:: Copyright (c) 2009 William Wolf
License:: Redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
=end

module Inox
  class Size < Struct.new(:width, :height)
    def initialize(*args)
      super(*(args.empty? ? [0,0] : args))
        unless self.width.kind_of? Numeric and self.height.kind_of? Numeric
          self.width = 0
          self.height = 0
        raise "#{args} not a two Numeric values"
      end
    end
    
    def width=(num)
       raise "#{num} not a Numeric value" unless num.kind_of? Numeric
       super(num)
    end
    
    def height=(num)
       raise "#{num} not a Numeric value" unless num.kind_of? Numeric
       super(num)
    end
      
    def to_size
      self
    end
    
    def to_h
      {:width => self.width, :height => self.height}
    end
  end
end

class Array
  def to_size
    raise "Cannot convert #{self} to Size" unless length == 2
    Inox::Size.new(self[0], self[1])
  end
end

class Hash
  def to_size
    raise "Cannot find keys 'width' and 'y'" unless key?(:width) and key?(:height) 
    Inox::Size.new(self[:width], self[:height])
  end
end
