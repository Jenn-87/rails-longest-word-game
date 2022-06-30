require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = grid
  end

  def score
    grid = params[:letters]
    @attempt = params[:attempt]
    @result = run_game(@attempt, grid)
  end

  def includes?(attempt, grid)
    attempt.split('').all? { |letter| grid.include? letter }
  end

  def run_game(attempt, letters)
    result = {}
    result[:translation] = check_translation(attempt)
    result[:message] = result_message(attempt, result[:translation], letters)
    result # why do I need to return result here?
end

private

  def grid
    ('a'..'z').to_a.sample(10).join
  end

  def result_message(attempt, translation, letters)
    if translation
      if includes?(attempt.upcase, grid)
        ["Congratulations! #{attempt} is a valid English word!"]
      else
        ["Sorry but #{attempt} can't be build out of #{grid} "]
      end
    else
      ["Sorry but #{attempt} does not seem to be a valid English word..."]
    end
  end

  def check_translation(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word.downcase}")
    json = JSON.parse(response.read.to_s)
    json["found"]
  end
end
