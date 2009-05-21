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
IX::import IX::source_file('core/action')
IX::import IX::source_file('core/property')

module Inox
  class ::Object
    def self.container?; false; end
    def container?; self.class.container?; end
  end

  class Component    
    include Actions
    include Properties

    attr_accessor :parent
    actions :create, :dispose, :parent_changed

    def initialize(the_parent = nil, *args, &block)
      self.parent = the_parent      
      create(*args, &block)
    end

    def parent=(obj)
      assert2(obj).nil?.or.kind_of?(Component).end
      old_parent = @parent
      @parent = obj
      parent_changed(old_parent)
    end

    def dispose!
      children.each { |c| c.dispose } if container?
      parent.remove_child(self) unless parent.nil? or not parent.container?
    end
  end

  module Container
    def self.included(base)
      with base do
        include Enumerable           
        
        actions :child_added, :child_removed
        
        def self.container?; true; end
        
        include InstanceMethods
      end
    end

    module InstanceMethods
      def children; @children ||= []; end
      
      def add_child(obj)
        assert2(obj).nil?.or.kind_of?(Component).end
        children << obj
        obj.parent = self
        child_added(obj)
      end
      alias << add_child

      def remove_child(obj)
        assert2(obj).not.nil?.and.kind_of?(Component).end
        res = children.delete(obj)
        unless res.nil?
          res.parent = nil
          child_removed(res)
        end
      end
    end
  end
end



