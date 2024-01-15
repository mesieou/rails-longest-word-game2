require "json"
require "open-uri"

class GamesController < ApplicationController
  def generate_letters
    letters = []
    quantity = (4..10).to_a.sample

    quantity.times do
      letter = ('a'..'z').to_a.sample
      letters << letter.capitalize
    end

    letters
  end

  def display_letters
    @letters = generate_letters
  end

  def score
    submitted_word = params[:word]
    submitted_letters = params[:word].downcase.split('')
    computer_letters = params[:letters].downcase.split('')

    @result = display_message(computer_letters, submitted_letters, submitted_word)
  end

  def display_message(computer_letters, submitted_letters, submitted_word)
    if !valid_word?(computer_letters, submitted_letters)
      'Sorry, some of the letters/letter are/is not in the grid given'
    elsif !english_word?(submitted_word)
      'Sorry, this is not a valid english word'
    else
      'Congratulations!'
    end
  end

  def valid_word?(computer_letters, submitted_letters)
    submitted_letters.all? do |letter|
      computer_letters.include?(letter) &&
        submitted_letters.count(letter) <= computer_letters.count(letter)
    end
  end

  def english_word?(submitted_word)
    url = "https://wagon-dictionary.herokuapp.com/#{submitted_word}"
    word_serialised = URI.open(url).read
    word_from_api = JSON.parse(word_serialised)
    word_from_api['found']
  end
end
