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

require 'core/delegate'
include Inox

class TestClass
  include Delegate
  
  action :foo
end

class TestController
  def foo
    :foo
  end
  
  def returnClass
    self.class
  end
end

describe TestClass do
  before :each do
    @test_class = TestClass.new
    @test_controller = TestController.new
  end
  
  it "should have an class action method" do
    TestClass.should respond_to(:action)
  end
  
  it "should have an class actions method" do
    TestClass.should respond_to(:actions)
  end
  
  it "action should create a new method" do
    @test_class.should respond_to(:foo)
  end
  
  it "should give access to a list of the actions" do
    a = TestClass.actions
    a.should  be_a_kind_of(Array)
    a.should == [:foo]
  end
  
  it "should respond to action_assigned?" do
    @test_class.should respond_to(:action_assigned?)
  end
  
  it "should respond to has_action?" do
    @test_class.should respond_to(:has_action?)
  end
  
  it "should give a list of actions" do
    @test_class.actions.should == TestClass.actions
  end
  
  it "has_action? should return true if the action exit" do
    @test_class.has_action?(:foo).should be(true)
  end
  
  it "has_action? should return false if the action doesn't exist" do
    @test_class.has_action?(:lala).should be(false)
  end
  
  it "the default of action_assigned? should be nil" do
    @test_class.action_assigned?(:foo).should be(false)
  end
  
  it "get_action should return nil" do
    @test_class.get_action(:foo).should be(nil)
  end
  
  it "the action should accept a block of code" do
    @test_class.foo {}
    @test_class.action_assigned?(:foo).should be(true)
  end
  
  it "the action should accept a assigment of a Proc object " do
    p = Proc.new { :hello }
    @test_class.foo = p 
    @test_class.action_assigned?(:foo).should be(true)
    @test_class.foo.should == :hello
  end
  
  it "the action should accept assign_method" do
    @test_class.foo = @test_controller.method(:foo)
    @test_class.action_assigned?(:foo).should be(true)
    @test_class.foo.should == :foo
  end
  
  it "should call the proc if no arguments pased" do
    test_data = "Test String"
    @test_class.foo { test_data}
    @test_class.foo.should be(test_data)
  end
  
  it "should accept arguments" do
    @test_class.foo { |x, y| x * y }
    @test_class.foo(9,3).should be(27)
  end
  
  it "when a block is given it should evaluate in the objects namespace" do
    @test_class.foo { self.class }
    @test_class.foo.should be(TestClass)
  end
  
  it "when assigned a method should be evaluate in the delegates namespace" do
    @test_class.foo = @test_controller.method(:returnClass)
    @test_class.foo.should be(TestController)
  end
end