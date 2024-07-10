# app/controllers/game_controller.rb
class GameController < ApplicationController
  def index
    @countries = CountryPopulation.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_order
    selected_country_ids = params[:countries]

    # Ensure selected_country_ids is an array if it's coming as a string
    selected_country_ids = selected_country_ids.is_a?(String) ? selected_country_ids.split(',') : selected_country_ids

    @correct = selected_country_ids.each_cons(2).all? do |a, b|
      CountryPopulation.find(a).population <= CountryPopulation.find(b).population
    end

    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by population."
      redirect_to root_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to root_path
    else
      @countries = CountryPopulation.find(selected_country_ids)
      render :index
    end
  end
end
