require 'Json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    @letters_string = @letters.join(';')
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(';')
    url = "https://wagon-dictionary.herokuapp.com/#{@word.gsub(' ', '')}"
    status = JSON.parse(URI.open(url).read)['found']
    modify_message(status)
  end

  private

  def check_for_letters
    return (@word.split('') & @letters) == @word.split('')
  end

  def modify_message(status)
    if status
      if check_for_letters
        @display_status = 'Correct Word! Congrats'
      else
        @display_status = 'Correct word but incorrect Letters. Sorry!'
      end
    else
      if check_for_letters
        @display_status = 'Incorrect word but correct letters. Almost there!'
      else
        @display_status = 'Are you even trying?'
      end
    end
  end
end
