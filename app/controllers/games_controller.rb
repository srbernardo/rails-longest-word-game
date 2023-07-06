require "net/http"
require "json"

class GamesController < ApplicationController

  def new
    @letras = ("a".."z").to_a.sample(10).join(" ")
  end

  def score
    @word = params[:word]
    @letras = params[:letras]
    url = URI.parse("https://wagon-dictionary.herokuapp.com/#{@word.downcase}")
    response = Net::HTTP.get_response(url)

    @tem_nas_letras = @word.downcase.chars.all? do |letra|
      @letras.include?(letra)
    end

    @data = JSON.parse(response.body)

    if @data["found"] == true
      if @tem_nas_letras
        @resposta = "Congratulations! #{@word.upcase} is a valid word!"
      else
        @resposta = "Sorry but #{@word.upcase} can't be built out of #{@letras.upcase.chars.join(' ')}"
      end
    else
      @resposta = "Sorry but #{@word.upcase} does not seem to be a valid word..."
    end

  end
end
