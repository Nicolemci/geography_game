# app/controllers/game_controller.rb
class GameController < ApplicationController
  def index
    @countries = CountryPopulation.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_order
    selected_countries = params[:countries]
    @correct = selected_countries.values.each_cons(2).all? do |a, b|
      CountryPopulation.find(a).population <= CountryPopulation.find(b).population
    end
    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by population."
      redirect_to root_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      @countries = selected_countries.values.map { |id| CountryPopulation.find(id) }
      render :index
    else
      @countries = selected_countries.values.map { |id| CountryPopulation.find(id) }
      render :index
    end
  end
end
