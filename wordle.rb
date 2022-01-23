# frozen_string_literal: true

require "colorize"
require "active_support/core_ext/array"
require "io/console"
require_relative "./dictionary"
require_relative "./visualizer"
require_relative "./system_utils"

class Wordle
  MAX_ATTEMPTS = 6
  WORD_LENGTH = 5

  def initialize
    @selected_word = WORD_LIST.sample
    @user_words = Array.new(MAX_ATTEMPTS, nil)
    @current_attempt = 0
    @word = nil
  end

  def play
    MAX_ATTEMPTS.times do |current_attempt|
      SystemUtils.clear
      puts "THE WORD: #{@selected_word}"
      visualize
      input_word

      if valid?
        @user_words[current_attempt] = @word

        if win_condition?
          puts "\nHooray! 🎉. \"#{@word}\" is the correct word!\n".colorize(color: :green)
          visualize
          return
        end
      else
        puts "#{@word} is not a #{WORD_LENGTH} letter word. Try again.".colorize(:red) unless valid_length?
        puts "You have already tried: #{@word}. Try again.".colorize(:red) if already_tried?
        puts "#{@word} is not in the dictionary. Try again.".colorize(:red) unless in_the_list?

        SystemUtils.press_any_key_to_continue
      end
    end

    puts "\nBuuuh! You failed! You looser! 😝. The correct word was \"#{@selected_word}\"\n".colorize(color: :red)
    visualize
  end

  private def input_word
    puts "\n"
    puts "Enter your #{WORD_LENGTH} letter word..."
    @word = gets.chomp.strip.downcase
    puts "\n\n"
  end

  private def visualize
    Visualizer.visualize(selected_word: @selected_word, word_list: @user_words, word_length: WORD_LENGTH)
  end

  private def win_condition?
    @word == @selected_word
  end

  private def loose_condition?
    @current_attempt >= MAX_ATTEMPTS
  end

  private def valid?
    valid_length? && !already_tried? && in_the_list?
  end

  private def valid_length?
    (@word.length == WORD_LENGTH)
  end

  private def already_tried?
    @user_words.include?(@word)
  end

  private def in_the_list?
    WORD_LIST.include?(@word)
  end
end

wordle = Wordle.new
wordle.play

