require "open-uri"
class GamesController < ApplicationController
  def new
    @random_letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    guess = params[:word].upcase.split('')
    grid = params[:letters].split
    if in_grid?(guess, grid) && english?(params[:word])
      @message = 'You win'
    elsif in_grid?(guess, grid)
      @message = 'Not an english word'
    elsif english?(params[:word])
      @message = 'Not in the grid'
    else
      @message = 'Neither an english word nor in the grid'
    end
  end

  def in_grid?(user_guess, grid)
    in_grid = user_guess.all? { |letter| user_guess.count(letter) <= grid.count(letter) }
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_results = open(url).read
    word_check = JSON.parse(serialized_results)
    english = word_check["found"]
  end
end
