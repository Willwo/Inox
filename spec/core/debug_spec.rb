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

describe 'assert' do
  it "should accept an object as argument" do
    lambda { assert(true) }.should_not raise_error
  end

  it "should return a AssertCases instance" do
    assert(true).should be_instance_of(Debug::Assertions)
  end

  specify "nil" do
    lambda { assert(1).nil }.should raise_error
    lambda { assert(nil).nil }.should_not raise_error
    
  end

  specify "not_nil" do
    lambda { assert(nil).not_nil }.should raise_error
    lambda { assert(1).not_nil }.should_not raise_error
  end

end