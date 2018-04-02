class GamesController < ApplicationController

  def new
    @results = []
    10.times { @results << ['A'..'Z'].to_a.sample }
  end

  def score
    @letters = params[:letters].split(' ')
    @attempt = params[:word].upcase
    word_found = word_check["found"]
    @results = if word_found
      enough_letters
    else
      #say not a word
    end
  end

  def word_check
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    JSON.parse(open(url).read)
  end

  def enough_letters
    @attempt.split.each do |letter|
      r
  end

  def results(score, message)
    {
      score: score,
      message: message
    }
  end
end
