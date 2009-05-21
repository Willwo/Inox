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
  # special case for application as it doe  # 
  def application(&block)
    app = Application.instance
    with(app, &block)
    app
  end
    
   def self.define_sugar_for(*syms)
    syms.each do |sym|
      class_eval %{ 
        def #{sym.to_s.downcase.to_sym}(&block)
          obj = #{sym}.new(self)
          with(obj, &block)
          self.add_child(obj) if self.container?
          obj
        end
        }
    end
  end
  
# define_sugar_for :Window, :Button
end