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

module Inox
  module Properties
    def self.included(base)
      # add class definitions
      with(base.meta_class) { include ClassMethods }

      # add instance definitions
      with(base) { include InstanceMethods }
    end

    ##########
    # Class Methods
    ##########   
    module ClassMethods
      attr_accessor :properties

      def has_properties?; true; end
      def has_property?(sym); properties.include? sym; end

      def properties(&block)
        @properties ||= Hash.new
        return @properties if block.nil?

        with meta_class do
          def self.method_missing(m, &b)
            @obj.add_property with(Property.new(m), &b)
          end

          def self.magic_eval(obj, &b)
            @obj = obj
            with(self, &b)
          end

          self
        end.magic_eval(self, &block)
      end

      def add_property(p)
        assert2(p).kind_of?(Property).and(self).not.has_property?(p.name).end
        properties[p.name] = p

        self.class_eval %{
          def #{p.name}(*arg)
            assert2(arg).empty?.or.length.eql?(1).end
            return property_get("#{p.name}".to_sym) if arg.empty?
            property_set("#{p.name}".to_sym, arg[0])
          end

          def #{p.name}=(p); property_set("#{p.name}".to_sym, p); end
        }

        property_added p
      end

      def define_property(name, type = Object, access = :readwrite, default = nil)
        add_property Property.new(name, type,access, default)
      end
      alias property define_property


      def remove_property(name)
        p = properties.delete(name)
        unless p.nil?
          with self do
            remove_method names
            remove_method "#{name}=".to_sym
          end
          property_removed v
        end
      end

      #call back
      def property_added(p); end
      def property_removed(p); end

      def inherited(sub)
        sub.properties = properties.clone if has_properties?
        sub.actions = actions.clone if has_actions?
      end        
    end # ClassMethods


    ##########
    # Instance methods
    ##########   
    module InstanceMethods

      def property_get(sym)
        property_missing(sym) unless self.class.has_property?(sym)

        if self.respond_to?("get_#{sym}".to_sym)
          send "get_#{sym}".to_sym
        else
          res = properties[sym]
          return res.nil? ? self.class.properties[sym].default : res
        end
      end

      def property_set(sym, value)
        property_missing(sym) unless self.class.has_property?(sym)

        if self.respond_to?("set_#{sym}".to_sym)          
          send "set_#{sym}".to_sym, value
        else
          properties[sym] = value
        end
      end

      def property_set!(sym, value)
        property_missing(sym) unless self.class.has_property?(sym)        
        properties[sym] = value
      end

      protected

      def properties; (@properties ||= Hash.new); end
      def property_missing(sym)
        raise "Property #{sym} not defined"
      end

    end    

  end # Module Properties

  # A class for representing propreties and their attributes
  class Property < Hash

    def initialize(aname = :New_Property, atype = Object, anaccess = :readwrite, adefault = nil)
      self.name, self.type, self.access, self.default = aname, atype, anaccess, adefault
    end

    def name=(v); name v; end
    def name(*arg)
      assert2(arg).empty?.or { length.eql?(1).and.at(0).kind_of?(Symbol) }.end

      return self[:name] if arg.empty?
      self[:name]=arg[0]        
    end  


    def type=(v); self[:type] = v; end
    def type(*arg)
      assert2(arg).empty?.or { length.eql?(1).and.at(0).kind_of?(Class) }.end

      return self[:type] if arg.empty?
      self.type = arg[0]
    end

    def default=(v); self.default(v); end
    def default(*arg)
      assert2(arg).empty?.or.length.eql?(1).end

      return self[:default] if arg.empty?
      self[:default] = arg[0]
    end

    def access=(v); self[:access] = v; end
    def access(*arg)
      assert2(arg).empty?.or.length.eql?(1).and.at(0)._{ 
        eql?(:read).or.eql?(:write).or.eql?(:readwrite) 
      }.end

      return self[:access] if arg.empty?
      self.access = arg[0] 
      end

      # some syntatic sugar
      def read; access(:read); end
      def read?; access == :read or access == :readwrite; end
      def write; access(:write); end
      def write?; access == :write or access == :readwrite; end
      def readwrite; access(:readwrite); end

    end # Class Properties

  end # Module Inox


  # added a default method the Object for introspection
  class Object
    def self.has_properties?; false; end
    def has_properties?; self.class.has_properties?; end
  end
