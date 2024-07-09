class GameController < ApplicationController
  def index
    @countries = Country.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_order
    selected_countries = params[:countries]
    @correct = selected_countries.values.each_cons(2).all? { |a, b| Country.find(a).population <= Country.find(b).population }
    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by population."
      redirect_to root_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to root_path
    else
      @countries = selected_countries.values.map { |id| Country.find(id) }
      render :index
    end
  end
end
