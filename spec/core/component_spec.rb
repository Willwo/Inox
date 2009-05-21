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

describe Component, "the Component Class" do
  it "should have properties" do
    Component.should respond_to(:properties)
  end

  it "should have actions" do
    Component.should respond_to(:actions)
  end

  it "should have a no properties" do
    Component.properties.empty?.should be(true)
  end

  it "should have standart actions" do
    Component.has_action?(:dispose).should be(true)
    Component.has_action?(:parent_changed).should be(true)
    Component.has_action?(:parent_changed).should be(true)
  end

  it "should have a method container?" do
    Component.should respond_to(:container?)
  end

  specify "container should be false" do
    Component.container?.should be(false)
  end

  it "should have actions" do
    Component.has_actions?.should be(true)
  end
end

describe Component, "the Instance" do      
  before :each do
    @c = Component.new(nil)
  end

  it "should accept a parent as initialization" do
    @c.parent.should == nil
  end
end

context 'Subclass of component includes container' do
  class Foo < Component
    include Container
  end

  describe Foo, 'the Subclass of Compnent' do
    it 'should have a method container?' do
      Foo.should respond_to(:container?)
    end

    specify 'container should be true' do
      Foo.container?.should be(true)  
    end

    it 'should have an action childAdded' do
      Foo.has_action?(:child_added).should be(true)
    end

    it 'should have an action childAdded' do
      Foo.has_action?(:child_removed).should be(true)
    end
  end

  describe Foo, 'an instance of the Subclass of Component' do
    before :each do
      @f = Foo.new
    end

    it "should call childAdded! with no error" do
      lambda { @f << @f }.should_not raise_error
    end

    it "should execute childAdded if assigned" do
      call_once = mock('call foo once')
      call_once.should_receive(:foo).once

      @f.on_child_added { call_once.foo }
      @f << @f
    end

    it "should call childRemoved! without errors" do
      @f << @f
      lambda { @f.remove_child(@f)  }.should_not raise_error
    end

    it "should execute childRemove if assigned" do
      call_once = mock('call foo once')
      call_once.should_receive(:foo).once

      @f << @f
      @f.on_child_removed { call_once.foo }
      @f.remove_child(@f)
    end

    it "should work with another component" do
      call_twice = mock('call foo once')
      call_twice.should_receive(:foo).twice

      @f.on_child_added { call_twice.foo }
      @f.on_child_removed { call_twice.foo }
      @f.children.length.should == 0
      c = Component.new(@f)
      c.parent.should == @f
      @f.add_child(c)
      @f.children.length.should == 1
      @f.children[0].should == c 
      @f.remove_child(c)
      @f.children.length.should == 0
    end
  end
end

context 'Deep hirarchy' do
  class A < Component
    actions :foo
  end
  class B < A
  end
  
  describe A do
    it "should have foo" do
      A.has_action?(:foo).should be(true)
    end
  end
  
  describe B do
    it "should have the action of A" do
      B.has_action?(:foo).should be(true)
    end
  end
end 

