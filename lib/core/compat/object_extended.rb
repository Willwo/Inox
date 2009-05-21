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



class ::Object

  def with(obj, &code)
    this = self
    obj.class.instance_eval { define_method :parent do; this; end }
    res = obj.kind_of?(Class) ? obj.class_eval(&code) : obj.instance_eval(&code)
    obj.class.instance_eval { remove_method :parent }
    obj
  end


  def meta_class
    class << self; self; end
  end
  
  def send!(symbol, *args, &block)
    if respond_to?(symbol)
      self.send(symbol, *args, &block)
    end
  end
end