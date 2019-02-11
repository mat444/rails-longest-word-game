require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase!
    @letters = params[:letters]
    test_letters = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    test_english = json['found']
    if test_letters == false
      @score = "Sorry but <strong>#{@word.upcase}</strong> can't be built out of #{@letters}"
    elsif test_english == false
      @score = "Sorry but <strong>#{@word.upcase}</strong> does not seem to be an english word..."
    else
      @score = "Congrats! Your score is #{@word.length}"
    end
  end
end
