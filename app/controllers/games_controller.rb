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
    raise

  end
end
