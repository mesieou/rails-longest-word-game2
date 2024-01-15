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
    submitted_letters = params[:word].downcase.split('')
    computer_letters = params[:letters].downcase.split('')

    @result = display_message(computer_letters, submitted_letters)
  end

  def display_message(computer_letters, submitted_letters)
    if valid_word?(computer_letters, submitted_letters)
      'Congratulations'
    else
      'Sorry'
    end
  end

  def valid_word?(computer_letters, submitted_letters)
    submitted_letters.all? do |letter|
      computer_letters.include?(letter) &&
        submitted_letters.count(letter) <= computer_letters.count(letter)
    end
  end
end
