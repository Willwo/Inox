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

require 'lib/inox'
include Inox

context 'Inox was required and included' do
  describe ContainerBase do
    it "should be kind of Component" do
      ContainerBase.class.should === Component
    end
    
    it "should have a property frame" do
      ContainerBase.has_property?(:frame).should be(true)
    end
    
    it "should have an action frameChanged" do
      ContainerBase.has_action?(:frame_changed).should be(true)
    end
  end
end