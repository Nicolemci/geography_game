# app/controllers/game_controller.rb
class GameController < ApplicationController
  def population
    @countries = CountryPopulation.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_population_order
    selected_country_ids = params[:countries]

    selected_country_ids = selected_country_ids.is_a?(String) ? selected_country_ids.split(',') : selected_country_ids

    @correct = selected_country_ids.each_cons(2).all? do |a, b|
      CountryPopulation.find(a).population <= CountryPopulation.find(b).population
    end

    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by population."
      redirect_to games_population_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to games_population_path
    else
      @countries = CountryPopulation.find(selected_country_ids)
      render :population
    end
  end

  def area
    @countries = CountryArea.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_area_order
    selected_country_ids = params[:countries]

    selected_country_ids = selected_country_ids.is_a?(String) ? selected_country_ids.split(',') : selected_country_ids

    @correct = selected_country_ids.each_cons(2).all? do |a, b|
      CountryArea.find(a).area <= CountryArea.find(b).area
    end

    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by area."
      redirect_to games_area_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to games_area_path
    else
      @countries = CountryArea.find(selected_country_ids)
      render :area
    end
  end

  def capital
    @countries = CountryCapital.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_capital_order
    selected_country_ids = params[:countries]

    selected_country_ids = selected_country_ids.is_a?(String) ? selected_country_ids.split(',') : selected_country_ids

    @correct = selected_country_ids.each_cons(2).all? do |a, b|
      CountryCapital.find(a).capital <= CountryCapital.find(b).capital
    end

    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by capital cities."
      redirect_to games_capital_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to games_capital_path
    else
      @countries = CountryCapital.find(selected_country_ids)
      render :capital
    end
  end
end
