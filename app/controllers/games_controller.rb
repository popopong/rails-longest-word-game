require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << (('A'..'Z').to_a + ('A'..'Z').to_a).sample }
  end

  def score
    @letters = params[:letters].split
    @answer = (params[:answer] || '').upcase
    @included = included?(@letters, @answer)
    @english = english?(@answer)
  end

  private

  def included?(letters, answer)
    splited = answer.split('')
    splited.all? { |letter| splited.count(letter) <= letters.count(letter) }
  end

  def english?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    json = JSON.parse(open(url).read)
    json["found"]
  end
end
