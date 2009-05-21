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
  class ButtonDelegate < OSX::NSObject
    def setTarget(target)
      @target = target
    end

    def clicked(sender)
      @target.send :clicked
    end
  end


  class Button < ButtonBase
    def create!
      @button = OSX::NSButton.alloc.initWithFrame(self.frame.to_a)
      @button.setAction :clicked
      del = ButtonDelegate.alloc.init
      del.setTarget self
      @button.setTarget del
      @button.setBezelStyle OSX::NSRoundedBezelStyle
    end
    
    def get_title
      @button.title.to_s
    end
    
    def set_title(v)
      @button.setTitle(v)
    end
    
    def native
      @button
    end

    def visible_set(v)
      if self.properties[:visible] != v then
        self.properties[:visible] = v
        @button.setHidden(v)
      end
    end
    
    def dispose!
      @button.release
      super
    end
    
    
    def frame_changed!
      super
      @button.setFrame(self.frame.to_a)
    end    
  end
end