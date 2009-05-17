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

require 'core/property'
include Inox

context 'a class includes properties' do
  class Foo
    include Properties
  end
  
  describe Foo, 'without properties' do
    it 'should have a property class method' do
      Foo.should respond_to(:property)      
    end
    
    it 'should have a properties class method' do
      Foo.should respond_to(:properties)      
    end
    
    # it 'should have a method has_properties?' do
    #   Foo.should respond_to(:has_properties?)
    #   Foo.has_properties?.should == false
    # end      
  end
  
  class Foo
    property {
      name :title
      readwrite
    }
  end
  
  # describe Foo, 'with a property title' do
  #     before :each do
  #       @foo = Foo.new
  #     end
  #     
  #     it 'should have a setter for title' do
  #       @foo.should respond_to(:title=)
  #     end
  #       
  #   end
end