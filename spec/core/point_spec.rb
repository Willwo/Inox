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

require 'point'
include Inox

describe Point do
  before :each do
    @p = Point.new
  end

  it "should have a property x" do
    @p.should respond_to(:x)
  end

  it "should have a property y" do
    @p.should respond_to(:y)
  end

  it "should have default x value of 0" do
    @p.x.should == 0
  end

  it "should have default y value of 0" do
    @p.y.should == 0
  end

  it "should have a setter for x" do
    @p.x = 1313
    @p.x.should == 1313
  end

  it "should have setter for y" do
    @p.y = 1313
    @p.y.should == 1313
  end
  
  it "should only accept numeric values for initialization" do
    lambda { Point.new('1', '2') }.should raise_error
  end

  it "should only accept numeric values for x" do
    lambda { @p.x = "String" }.should raise_error
  end

  it "should only accept numeric values for y" do
    lambda { @p.y = "String" }.should raise_error
  end

  it "should being able to compare ==" do
    p2 = Point.new
    @p.should == p2
    p2.x = 1313
    @p.should_not == p2
    @p.should_not == "Test"
  end

  it "should be castable to an array" do
    @p.should respond_to(:to_a)
    @p.to_a.should == [0,0]
  end

  it "should be castable to an hash" do
    @p.should respond_to(:to_hash)
    @p.to_hash.should == {:x => 0, :y => 0}
  end
  
  it "should be castable to Point" do
    @p.should respond_to(:to_point)
    @p.to_point.should == @p
  end

  it "an array of two elements should be castable to Point" do
    p = [0,0].to_point
    p.should == @p
  end

  it "an array contain more than 2 elements raise error" do
    lambda { p = [1,2,3].to_point }.should raise_error
  end

  it "a hash containing { :x => value, :y =>value} should be castable to Point" do
    p = {:x => 0, :y => 0}.to_point
    p.should == @p
  end

  it "a hash to_point should raise if the keys :x and :y are not found" do
    lambda { p = {}.to_point }.should raise_error
  end
end