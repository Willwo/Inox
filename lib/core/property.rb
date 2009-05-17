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

    class Property < Hash
      def name(*arg)
        if arg.empty?
          return self[:name]
        elsif arg.length == 1 and arg[0].kind_of?(Symbol)
          self[:name] = arg[0] 
          return nil
        else
          raise "Symbol expect for Property.name"
        end
      end  

      def default(*arg)
        if arg.empty?
          return self[:default] 
        elsif arg.length == 1
          self[:default] = arg[0]
          return nil
        else
          raise "Zero or one argument expected"
        end
      end

      def access(*arg)
        return self[:access] if arg.empty?
        self[:access] = arg[0] if arg.length == 1 and 
        arg[0].kind_of?(Symbol) and (
        arg[0] == :read or 
        arg[0] == :write or 
        arg[0] == :readwrite)
        nil
      end

      def read
        self.access(:read)
      end
      
      def read?
        self.access == :read or 
        self.access == :readwrite
      end

      def write
        self.access(:write)
      end
      
      def write?
        self.access == :write or 
        self.access == :readwrite
      end

      def readwrite
        self.access(:readwrite)
      end
      
      def value(*arg)
        if arg.empty?
          return self[:value]
        elsif arg.length == 1
          self[:value] = arg[0]
        else
          raise "Zero or one argument expected"
        end
      end
    end


    def self.included(base)
      class << base
        attr_accessor :properties

        def property(&block)
          p = Property.new
          p.instance_eval(&block)
          self.properties[p.name] = p
          p
        end

        def properties(&block)
          @properties ||= Hash.new
          return @properties if block.nil?
          class << self
            def self.method_missing(m, &block)
              p = Property.new
              p.instance_eval(&block)
              p.name(m)
              @obj.properties[p.name] = p
              p
            end

            def self.magic_eval(obj, &block)
              @obj = obj
              self.instance_eval(&block)
            end

            self
          end.magic_eval(self, &block)

        end

        def inherited(subclass)
          subclass.properties = self.properties.clone
        end        
      end        
    end
  end

end 
