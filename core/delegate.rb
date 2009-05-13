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


# required if ruby version < 1.9
# TODO move into main inox.rb files when it is created
require 'core/ruby1_8'

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
  module Delegate

    # add class methods: action, actions
    def self.included(othermod)
      othermod.module_eval %{
        @@actions = []

        # defines one action
        def self.action(sym)
          @@actions << sym
          self.class_eval %{
            def \#{sym}(*args, &block)
              self.perform_action("\#{sym}".to_sym, *args, &block)
            end

            def \#{sym}=(p)
              if p.kind_of?(Proc) or p.kind_of?(Method) then
                self.set_action("\#{sym}".to_sym, p)
              elsif p.nil?
                self.set_action("\#{sym}".to_sym, nil)
              else
                raise "Proc or Method expected"    
              end
            end
          }
        end

        # called without args returns a list of
        # defined actions
        def self.actions(*args)
          if args.empty?
            @@actions
          else
            args.each { |a| self.action(a) }
          end
        end
      }
    end

    # set all the actions to call only the methods of one
    # delegate object
    # if obj if nil than resets all the actions to nil
    def delegate=(obj)
      self.actions.each { |a|
        if obj.respond_to?(a)
          self.call_action!(a, assign_method(obj, a))
        else
          self.set_action(a, nil)
        end
      }
    end

    # return the block/proc/method associated with the action
    def get_action(sym)
      @actions.nil? ? nil : @actions[sym]
    end

    # associates an action with a proc/block/method
    def set_action(sym, proc)
      @actions = Hash.new if @actions.nil?
      @actions[sym] = proc 
      return nil
    end

    # returns true or false whenever a block/proc/method is
    # assicated with the action
    def action_assigned?(sym)
      not get_action(sym).nil?
    end

    # returns a list of defined actions
    def actions
      self.class.actions
    end

    # returns if this object has a given action
    def has_action?(sym)
      not self.actions.index(sym).nil?
    end

    # executes the action if assigned
    def call_action(sym, *args)
      action = self.get_action(sym)
      action.nil? ? nil : self.instance_exec(*args, &action) 
    end

    protected

    # used by the metaprogramming to setup the stup method 
    # for the action
    def perform_action(sym, *args, &block)
      case (args.empty? ? 0b0 : 0b1) | (block.nil? ? 0b10 : 0b100)
      when 0b10 then self.call_action(sym)
      when 0b100 then self.set_action(sym, block)
      when 0b11 then self.call_action(sym, *args)
      when 0b101 then args << block; self.call_action(sym, *args)
      end
    end

  end
end


