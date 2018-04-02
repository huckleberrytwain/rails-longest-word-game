require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(' ')
    @attempt = params[:word].upcase
    word_found = word_hash(@attempt)["found"]
    @results = if word_found
      enough_letters
    else
      results_hash(0, "because that is not an english word. Idiot.")
    end
  end

  def word_hash(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    JSON.parse(open(url).read)
  end

  def results_hash(score, message)
    {
      score: score,
      message: message
    }
  end

  def enough_letters
    @attempt.split('').each do |letter|
      return results_hash(0, "because you don't have the letters for that word. Stupid.") unless @letters.include?(letter)
      @letters.delete(letter)
    end
    results_hash(@attempt.length, "because that is a word. Well done.")
  end
end
