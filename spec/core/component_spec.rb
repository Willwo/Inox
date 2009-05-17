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

require 'core/component'
include Inox

describe Component do
  it "should have properties" do
    Component.should respond_to(:properties)
  end
  
  it "should have actions" do
    Component.should respond_to(:actions)
  end
  
  # it "should have a property title" do
  #   Component.properties[:title].should_not be(nil)
  # end
  # 
  # it "should title be assignable" do
  #   c = Component.new(nil)
  #   c.title = "Hello World"
  # end

end