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


require 'core/size'
include Inox

describe Size do
  before :each do
    @p = Size.new
  end

  it "should have property width" do
    @p.should respond_to(:width)
  end

  it "should have a property height" do
    @p.should respond_to(:height)
  end

  it "should have default width value of 0" do
    @p.width.should == 0
  end

  it "should have default height value of 0" do
    @p.height.should == 0
  end

  it "should have a setters for width" do
    @p.width = 1313
    @p.width.should == 1313
  end

  it "should have setters for height" do
    @p.height = 1313
    @p.height.should == 1313
  end

  it "should onlheight acceppt numeric values for width" do
    lambda { @p.width = "String" }.should raise_error
  end

  it "should only acceppt numeric values for height" do
    lambda { @p.height = "String" }.should raise_error
  end
  
  it "should only accept numeric values for initialization" do
    lambda { Size.new('1', '2') }.should raise_error
  end


  it "should being able to compare ==" do
    p2 = Size.new
    @p.should == p2
    p2.width = 1313
    @p.should_not == p2
    @p.should_not == "Test"
  end

  it "should be castable to an array" do
    @p.should respond_to(:to_a)
    @p.to_a.should == [0,0]
  end

  it "should be castable to a hash" do
    @p.should respond_to(:to_h)
    @p.to_h.should == {:width => 0, :height => 0}
  end

  it "an array of two elements should be castable to Size" do
    p = [0,0].to_size
    p.should == @p
  end

  it "an array contain more than 2 elements raise error" do
    lambda { p = [1,2,3].to_size }.should raise_error
  end

  it "a hash containeing width => value, height => value should be castable to Size" do
    p = {:width => 0, :height => 0}.to_size
    p.should == @p
  end

  it "a hash to_Size should raise if the keys :width and :height are not found" do
    lambda { p = {}.to_size }.should raise_error
  end

end