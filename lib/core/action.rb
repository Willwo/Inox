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
IX::import IX::source_file('core/compat/debug.rb')

module Inox

  # When included into a class, creates the default behavior as follow:
  # f.ex
  #
  # class Button
  #    include Delegate
  #    actions :clicked, :focused  
  #
  #    def __ugly_callback_for_os(sender)
  #      self.clicked(sender)
  #    end  
  # end
  #
  # btn = Button.new
  # bt.clicked { puts "This #{self} was clicked" }
  #
  # 
  module Actions
    def self.included(base)
      # add class methods
      with base do
        extend ClassMethods
      end

      # add instance methods
      with base do
        include InstanceMethods
      end
    end


    ##########
    # Class methods
    ##########    
    module ClassMethods
      attr_accessor :actions

      def has_actions?; true; end
      def has_action?(sym); self.actions.include?(sym); end

      def actions(*args)
        return @actions ||= [] if args.empty?
        args.each { |a| self.define_action(a) }
      end


      def define_action(sym)
        assert2(self.actions).not.include?(sym).end

        self.actions << sym

        self.class_eval %{
          def #{"on_#{sym}".to_sym}(&block)
            self.action_assign("#{sym}".to_sym, block)  
          end

          def #{sym}=(p)
            assert2(p).nil?.or.kind_of?(Proc).or.kind_of?(Method).end
            action_assign("#{sym}".to_sym, nil)
          end

          def #{sym}(*args, &block)
            s = "#{sym}".to_sym
            if self.has_action?(s) and self.action_assigned?(s)
              self.action_call("#{sym}".to_sym, *args, &block)
            end            
            self.#{sym}!(*args,&block)  
          end
          
          def #{sym}!(*args, &block)
          end
        }
        action_added(sym)
      end
      alias action define_action


      def remove_action(sym)
        res = actions.delete(sym)
        unless res.nil?
          with self do
            remove_method(sym)
            remove_method("#{sym}=".to_sym)
          end 
          action_removed(sym)            
        end
      end

      #
      # callbacks
      #
      def action_added(sym); end
      def action_removed(sym); end
      ##

      def inherited(subclass)
        if has_properties?
          subclass.properties = self.properties.clone
        end
        if has_actions?
          subclass.actions = self.actions.clone
        end
      end  

    end #Class Methods

    ##########
    # Instance methods
    ##########    
    module InstanceMethods
      # returns a list of defined actions
      def actions; self.class.actions; end

      # set all the actions to call only the methods of one
      # delegate object
      # if obj if nil than resets all the actions to nil
      def actions=(obj)
        actions.each { |a| action_assign(a, obj.method(a)) }
      end

      # return the block/proc/method associated with the action
      def action(sym); @actions.nil? ? nil : @actions[sym] end

      # associates an action with a proc/block/method
      def action_assign(sym, proc)
        (@actions ||= Hash.new)[sym] = proc
        send! :action_assigned, sym, proc
      end

      # returns true or false whenever a block/proc/method is
      # assicated with the action
      def action_assigned?(sym); not action(sym).nil?; end

      # returns if this object has a given action
      def has_action?(sym); self.class.has_action?(sym); end

      # callback(s)
      def action_assigned(sym, block); end
      def action_unassigned(sym)
        raise "Action #{sym} not assigned"
      end
      def action_missing(sym)
        raise "Action #{sym} not defined"
      end


      protected

      # executes the action if assigned
      #
      # obj.actions[:foo].call
      def action_call(sym, *args)
        return action_missing(sym) unless has_action?(sym)
        action = self.action(sym)
        return action_unassigned(sym) if action.nil?
        return instance_exec(*args, &action) 
      end
      
    end # Instance Methods

  end # Module Actions

end # Module Inox

# added a default method the Object for introspection
class Object
  def self.has_actions?; false; end
  def has_actions?; self.class.has_actions?; end
end


