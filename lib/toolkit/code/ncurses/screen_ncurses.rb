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
  class Screen < ScreenBase
    
    #http://www.koders.com/ruby/fid489BFEC93438D22D6EE4B42B7C4252F75EEAC1E8.aspx?s=cdef%3Aaccount
    def rows
      lame, lamer = [], []
      @stdscr.getmaxyx lame, lamer
      lame.first
    end

    #http://www.koders.com/ruby/fid489BFEC93438D22D6EE4B42B7C4252F75EEAC1E8.aspx?s=cdef%3Aaccount
    def cols
      lame, lamer = [], []
      @stdscr.getmaxyx lame, lamer
      lamer.first
    end
    
    def native
      @stdscr
    end

    def create!
      super
       @stdscr = Ncurses.initscr
      Ncurses.start_color()
      Ncurses.cbreak();
      Ncurses.noecho();
  
      Ncurses.init_pair(1, Ncurses::COLOR_BLACK, Ncurses::COLOR_WHITE);
      @stdscr.bkgd(Ncurses.COLOR_PAIR(1))
      @stdscr.refresh
      self.frame = [0,0,rows,cols]
      $__exit_handlers << Proc.new {
        Ncurses.endwin
      }
    end
    
    def dispose!
      exit(0)
    end
  end
end