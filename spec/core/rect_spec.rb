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

require 'core/rect'
include Inox

describe Rect do
  before :each do
    @r  = Rect.new
  end
  
  it "should have a property origin" do
    @r.should respond_to(:origin)
  end
  
  it "should have a property size" do
    @r.should respond_to(:size)
  end
  
  it "origin has a initial value of [0, 0]" do
    @r.origin.should  == [0,0].to_point
  end
  
  it "size has an initial value of [0, 0]" do
    @r.size.should == [0,0].to_size
  end
  
  it "should be comparable with ==" do
    r2 = Rect.new
    @r.should == r2
    @r.should == [0,0,0,0]
  end
  
  it "should be castable to rect" do
    @r.should respond_to(:to_rect)
    @r.to_rect.should == @r
  end
end