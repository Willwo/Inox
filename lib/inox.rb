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

# alias old_req require
# def require(arg)
#   puts "File #{arg} required"
#   old_req(arg)
# end

module Inox  
#########################################################################
# Global defined
#########################################################################  
  
  # Global version of Inox
  INOX_VERSION = '0.0.1'
  
  # should point to the lib path of Inox
  # since we are loading a lot of stuff, we can speed up
  # by using absolute paths so that require doesn't need
  # to search through $LOAD_PATH
  INOX_PATH = File.dirname(__FILE__)

  
  
  # strictly use import so the behavior can be
  # addapted/extended later
  # if passed a proc it get exectued so we can define handlers
  # for different kinds of imports
  def self.import(obj)
    if obj.kind_of?(Proc)
      obj.call
    else
      require(obj)
    end
  end
  
  def self.source_file(afile)
    lambda {
      import "#{INOX_PATH}/#{afile}"
    }
  end
  
  def self.source_files(glob)
    lambda {
      Dir["#{INOX_PATH}/#{glob}"].each { |f|
        import f
      }
    }
  end

end #module Inox

IX = Inox  
  
#########################################################################
# CORE source
# This is a platform independent layer of classes introducing the required
# tools for Inox.
#########################################################################

IX::import IX::source_file('core/core.rb')
  
  
  
#########################################################################
# Toolkit source
# load the toolkit classes
#########################################################################

# include all definition in the Inox module!
IX::import IX::source_file('toolkit/toolkit.rb')


  
  
