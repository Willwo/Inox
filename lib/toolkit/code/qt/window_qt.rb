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
    def create      
     @window = Qt::Widget.new(nil)
     t = self.class.properties[:title].default
      with @window do
        setWindowTitle(t)
        setGeometry(200, 200, 200,200)
        show()
      end
    end

    def native
      @window
    end
    
    protected
    
    def dispose
      @window.release
    end
    
    def title_get; @window.windowTitle.to_s; end
    def title_set(v); @window.setWindowTitle(v); end
    def frame_changed(f)
      @window.setGeometry f
      super
    end


  end
end
