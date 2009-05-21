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


context 'property.rb included' do
  describe Class do
    it "should have a has_properties? method" do
      Class.should respond_to(:has_properties?)
    end

    specify "has_properties? should return false" do
      Class.has_properties?.should be(false)
    end
  end

  describe Object do
    it "should have a has_properties method" do
      Object.should respond_to(:has_properties?)
    end

    specify "has_properties? should return false" do
      Object.has_properties?.should be(false)
    end
  end

  describe Property do
    before :each do
      @p = Property.new
    end

    it "should have default values" do
      @p.name.should == :New_Property
      @p.type.should == Object
      @p.access.should == :readwrite
      @p.default.should == nil
    end

    it "should have setter for name" do
      @p.name = :test
      @p.name.should == :test
      @p.name :foo
      @p.name.should == :foo
    end

    specify "passing non Symbol raises an error" do
      lambda { @p.name = "Hello" }.should raise_error
    end

    specify "passing more than one arg raises an error" do
      lambda { @p.name(1,2,3) }.should raise_error
    end

    it "should have setter for type" do
      @p.type = String
      @p.type.should == String
      @p.type Class
      @p.type.should == Class
    end

    specify "should raise an error for a non class" do
      lambda { @p.type 1 }.should raise_error
    end

    specify "should raise an error for more than one arg" do
      lambda { @p.type(1,2,3) }.should raise_error
    end

    it "should have a setter for default" do
      @p.default = 'Test'
      @p.default.should == 'Test'
      @p.default 'Hello'
      @p.default.should == 'Hello'
    end

    it "should have a setter for access" do
      @p.access = :read
      @p.access.should == :read
      @p.access :write
      @p.access.should == :write
    end

    specify "should have shortcuts methods [read, write, readwrite]" do
      @p.should respond_to(:read)
      @p.read
      @p.access.should == :read
      @p.should respond_to(:write)
      @p.write
      @p.access.should == :write
      @p.should respond_to(:readwrite)
      @p.readwrite
      @p.access.should == :readwrite
    end

  end
end

context 'a class includes properties' do
  class Foo
    include Properties
  end

  describe Foo, 'without properties' do
    it 'should have a method has_properties?' do
      Foo.should respond_to(:has_properties?)
    end   

    specify 'has_properties? should return true' do
      Foo.has_properties?.should be(true)
    end

    it 'should have a properties class method' do
      Foo.should respond_to(:properties)      
    end

    specify 'properties should be empty' do
      Foo.properties.empty?.should be(true)
    end

    it 'should have a methd has_property?' do
      Foo.should respond_to(:has_property?)
    end

    specify 'returns false for nonexistant property' do
      Foo.has_property?(:foo).should be(false)
    end

    it 'should have a method define_property' do
      Foo.should respond_to(:define_property)      
    end

    it 'should have a method property' do
      Foo.should respond_to(:property)      
    end

    it 'should have a method remove_property' do
      Foo.should respond_to(:remove_property)
    end

    it 'should have an empty callback property_added' do
      Foo.should respond_to(:property_added)
      Foo.property_added(nil).should == nil
    end

    it 'should have an empty callback property removed' do
      Foo.should respond_to(:property_removed)
      Foo.property_removed(nil).should == nil
    end

    it 'should have a method inherited' do
      Foo.should respond_to(:inherited)
    end
  end

  describe Foo, 'with properties' do
    specify 'define_property creates a new property' do
      Foo.properties.empty?.should be(true)
      Foo.define_property :foo
      Foo.properties.empty?.should be(false) 
      Foo.has_property?(:foo).should be(true)    
    end

    specify 'the defined property should have the default options' do
      Foo.define_property :foo
      p = Foo.properties[:foo]
      p.name.should == :foo
      p.access.should == :readwrite
      p.type.should == Object
      p.default.should == nil
    end

    specify 'when a property is added the callback is called' do
      class Test < Foo
        def self.property_added(p)
          raise
        end
      end
      lambda { Test.define_property :foo }.should raise_error
    end

    specify 'when a property is removed the callback is called' do
      class Test2 < Foo
        property :foo
        def self.property_removed(p)
          raise
        end
      end
      lambda { Test2.remove_property :foo }.should raise_error
    end

    specify 'when inherited the subclass shares the same properties' do
      Foo.remove_property(:foo) if Foo.has_property?(:foo)

      class A < Foo
      end
      class B < A
        property :foo
      end
      class C < B
      end

      A.has_property?(:foo).should be(false)
      B.has_property?(:foo).should be(true)
      C.has_property?(:foo).should be(true)

      B.remove_property(:foo)
      C.has_property?(:foo).should be(true)
    end
  end

  describe Foo, 'the instances of Foo' do
    before :each do
      Foo.remove_property(:foo) if Foo.has_property?(:foo)
      Foo.define_property :foo, String, :readwrite, 'Hello'
      @f = Foo.new
    end
    
    specify 'has_properties? shoud return true' do
      @f.has_properties?.should be(true)
    end
    
    specify 'should have setters/getters for properties' do
      @f.should respond_to(:property_set)
      @f.should respond_to(:property_get)
      @f.property_set(:foo, 1313)
      @f.property_get(:foo).should be(1313)
    end
    
    specify 'should have setters and getters methods' do
      @f.should respond_to(:foo)
      @f.foo = 1414
      @f.foo.should be(1414)
      @f.foo 'test'
      @f.foo.should == 'test'
    end
    
  end

end