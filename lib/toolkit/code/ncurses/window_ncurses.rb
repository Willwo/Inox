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
  class Window < WindowBase
    def create!      
    end

    def native
    end

protected    
    def set_visible(v)
    end
    
    def child_added!(obj)
      super(obj)

    end
          
    def get_title; @window.title.to_s; end
    def set_title(v); @window.setTitle(v); end
    def frame_changed!
      super
    end


  end
end
