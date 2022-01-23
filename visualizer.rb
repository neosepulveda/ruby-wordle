# frozen_string_literal: true

require "colorize"

class Visualizer
  def self.visualize(selected_word:, word_list:, word_length:)
    new(selected_word, word_list, word_length).visualize
  end

  def initialize(selected_word, word_list, word_length)
    @selected_word = selected_word
    @word_list = word_list
    @word_length = word_length
  end

  def visualize
    match = @selected_word.chars
    @word_list.each do |word|
      if word.nil?
        puts @word_length.times.map { generate_empty_square }.join(" ")
      else
        line = word.chars.each_with_index.map do |character, index|
          generate_square(match, character, index)
        end.join(" ")
        puts line
      end
      puts "\n"
    end

    # (MAX_ATTEMPTS - @current_attempt + 1).times do
    #   puts WORD_LENGTH.times.map { generate_empty_square }.join(" ")
    #   puts "\n"
    # end
  end

  private def generate_square(match, character, index)
    color =
      if match[index] == character # correct
        :green
      elsif match.include?(character) # exists in the word but its not the right position
        :yellow
      else
        :black # doesn't exist in the word
      end

    " #{character} ".colorize(background: color)
  end

  private def generate_empty_square
    "   ".colorize(background: :light_blue)
  end
end