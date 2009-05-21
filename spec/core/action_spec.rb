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

context 'action.rb required and Inox included' do  
  describe Class do
    it "should have a has_actions method" do
      Class.should respond_to(:has_actions?)
    end

    specify "has_actions? should return false" do
      Class.has_actions?.should be(false)
    end
  end

  describe Object do
    it "should have a has_actions method" do
      Object.should respond_to(:has_actions?)
    end

    specify "has_actions? should return false" do
      Object.has_actions?.should be(false)
    end
  end
end

context 'a class includes the Actions module' do
  class TestClass
    include Actions
  end

  describe TestClass do
    it 'should repond to has_actions?' do
      TestClass.should respond_to(:has_actions?)
    end

    specify 'has_actions? should be enabled' do
      TestClass.has_actions?.should be(true)
    end


    it 'should have a class actions method' do
      TestClass.should respond_to(:actions)
    end

    specify 'actions should retrun an empty array' do
      TestClass.actions.empty?.should be(true)
    end


    it 'should have a class method action' do
      TestClass.should respond_to(:action)
    end

    specify 'action should create a new action' do
      TestClass.action :foo
      TestClass.actions.should == [:foo]
    end

    specify 'if invoked twice with the same sym should raise an error' do
      lambda { TestClass.action :foo }.should raise_error
    end

    it 'should have a class method remove_action' do
      TestClass.should respond_to(:remove_action)
    end

    specify 'remove_action should remove the specified action' do
      TestClass.remove_action :foo
      TestClass.actions.should == []
    end


    context 'the instance of TestClass' do
      before :each do
        with TestClass do
          action :foo unless has_action?(:foo)
        end

        @t = TestClass.new
      end

      it 'should repsons to a method foo' do
        @t.should respond_to(:foo)
      end

      specify 'on_foo should accept a proc' do
        lambda { @t.on_foo {} }.should_not raise_error        
      end

      it 'should have a action_assigned?' do
        @t.should respond_to(:action_assigned?)
      end

      specify 'action_assigned? should return false' do
        @t.action_assigned?(:foo).should be(false)
      end

      specify 'actions_assigned? should return true' do
        @t.on_foo {}
        @t.action_assigned?(:foo).should be(true)
      end        
        
      specify "should call the proc if no arguments pased" do
        test_data = "Test String"
        @t.on_foo { test_data }
        @t.foo.should be(test_data)
      end
      
      specify "should accept arguments" do
        @t.on_foo { |x, y| x * y }
        @t.foo(9,3).should be(27)
      end
      
      specify "called with a bang it should check if the action is assigned" do
        lambda { @t.foo! }.should_not raise_error
      end
        
      
      specify "when a block is given it should evaluate in the objects namespace" do
        @t.on_foo { self.class }
        @t.foo.should be(TestClass)
      end
      
      specify "should unset the action if assigned nil" do
        @t.on_foo { "Hello" }
        @t.foo = nil
        lambda { @t.foo }.should raise_error
      end
      
      specify "if inherited the subclass should have access to the same methods" do
        class Test2Class < TestClass
        end
        Test2Class.actions.should == TestClass.actions
      end

      specify "when assigned a method should be evaluate in the delegates namespace" do
        class TestController
          def returnClass;  self.class; end
        end
        test_controller = TestController.new
        @t.foo = test_controller.method(:returnClass)
        @t.foo.should be(TestController)
      end
      
      specify "actions= assigns all the actions" do
        @t.on_foo { raise }
        @t.actions = nil
        lambda { @t.foo }.should raise_error
      end
      
      specify "actions= assigns all the methods of the controller object" do
        class TestController
          def foo
            raise
          end
        end
        @t.actions = TestController.new
        lambda { @t.foo! }.should raise_error
      end
      
      specify "deeply inherited" do
        class A
        end
        class B < A
          include Actions
          
          action :boo
        end
        class C < B
          action :foo
        end
        class D < C
        end
        D.has_action?(:foo).should be(true)
        d = D.new
        d.has_action?(:foo).should be(true)
      end
        
        
        
    end

  end
end