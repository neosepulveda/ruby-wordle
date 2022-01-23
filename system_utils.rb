# frozen_string_literal: true

require "colorize"
require "io/console"

class SystemUtils
  def self.clear
    if Gem.win_platform?
      system 'cls'
    else
      system 'clear'
    end
  end

  def self.press_any_key_to_continue                                                                                                               
    print "\npress any key to continue...".colorize(color: :yellow)                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r"                                                                                                             
  end
end