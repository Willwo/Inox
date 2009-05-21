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
require 'lib/inox'
include Inox


application {
  # w= window {
  #   title 'test 2'
  #   
  #   button {
  #     title 'Quit'
  #     frame [10, 10, 96, 32]
  #     on_clicked { Application.instance.dispose }
  #   }
  #   
  #   button { title 'OK?'; frame [110,10,96,32] }
  # }
  # 
  # 
  # w.visible = true
  run
}



