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

#########################################################################  
# Pre Code
#
# Defines the base Classes to be subclassed by a Toolkit
# other requirements for all the toolkits should be in
# the pre_code folder
# Files in the pre_code should be platform agnostic
#########################################################################  
IX::import IX::source_files('toolkit/pre_code/*.rb')


#########################################################################  
# Platform dependent toolkit
#
# Try to figure out on which platform we are running
# try to select the user prefered toolkit for his platform
# load the platform depended code
#########################################################################  
  
# if /darwin/ =~ RUBY_PLATFORM then
#     require "#{File.dirname(__FILE__)}/cocoa/cocoa.rb"
# 
# else
#     raise "Platform #{RUBY_PLATFORM} not implmented yet."
# end

IX::import IX::source_file('toolkit/code/cocoa/cocoa.rb')
#require "#{File.dirname(__FILE__)}/code/qt/qt.rb"
IX::import IX::source_file('toolkit/code/ncurses/ix_ncurses.rb')


#########################################################################  
# Post Code
#
# The toolkit is loaded and all the class are defined
# platform agnostic code that extend the functionality of
# of the toolkit goes here.
#########################################################################  

IX::import IX::source_files('toolkit/post_code/*.rb')
