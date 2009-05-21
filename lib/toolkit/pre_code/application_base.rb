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
IX::import IX::source_file('toolkit/pre_code/container_base.rb')

module Inox
  class ApplicationBase < ContainerBase
    include Singleton

    properties {
      title { type String; readwrite; default 'Inox Application' }
    }

    def initialize(*args, &block)
      super(*args, &block)
      self.parent = Screen.instance()
      self.frame = self.parent.frame
    end
    
    def child_removed!(obj)
      dispose if children.length == 0
    end
  end
end