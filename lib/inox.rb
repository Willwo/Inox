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
#########################################################################
# Global defined
#########################################################################  
  
  # Global version of Inox
  INOX_VERSION = '0.0.1'


end #module Inox



#########################################################################
# Compatibility
# Any compatiblity between different Ruby version and/or OSs goes here.
# Hacks should be in 'compat/*_hack.rb'
# NO compatibility tricks allowed in 'core/*.rb' files!!
#########################################################################

require 'compat/compat.rb'
  
  
  
#########################################################################
# CORE source
# This is a platform independent layer of classes introducing the require
# tools, require by Inox.
#########################################################################

require 'core/core.rb'  
  
  
  
#########################################################################
# Toolkit source
# we define and redefine all the classes in toolkits all over again. 
#########################################################################

require 'toolkit/toolkit.rb'
  
  
  
