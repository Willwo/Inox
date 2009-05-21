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
  
  class WindowDelegate < OSX::NSObject
    def setTarget(target)
      @target = target
    end
    
    def windowWillClose(notification)
      @target.send :dispose
    end
  end


  class Window < WindowBase
    def create!      
      styleMask = OSX::NSTitledWindowMask + OSX::NSClosableWindowMask +
    OSX::NSMiniaturizableWindowMask + OSX::NSResizableWindowMask

      @window = OSX::NSWindow.alloc.initWithContentRect_styleMask_backing_defer(
        self.frame.to_a, styleMask, OSX::NSBackingStoreBuffered, false)
        
      t = self.class.properties[:title].default
      @window.setTitle(t)
      delegate = WindowDelegate.alloc.init
      delegate.setTarget self
      @window.setDelegate(delegate)
    end

    def native
      @window
    end

protected    
    def set_visible(v)
      if self.properties[:visible] != v then
        self.properties[:visible] = v
        if v then
          @window.orderFront(nil)
        else
          @window.orderOut(nil)
        end
      end
    end
    
    def child_added!(obj)
      super(obj)
      @window.contentView.addSubview(obj.native)
    end
          
    def get_title; @window.title.to_s; end
    def set_title(v); @window.setTitle(v); end
    def frame_changed!
      super
      @window.setFrame_display(self.frame.to_a,true)
    end


  end
end
