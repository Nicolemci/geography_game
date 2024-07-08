class GameController < ApplicationController
  def index
    @countries = Country.order("RANDOM()").limit(10)
    @turns_left = 5
  end

  def check_order
    selected_countries = params[:countries]
    @correct = selected_countries.each_cons(2).all? { |a, b| Country.find(a).population <= Country.find(b).population }
    @turns_left = params[:turns_left].to_i - 1

    if @correct
      flash[:notice] = "Congratulations! You got it right!"
    elsif @turns_left == 0
      flash[:alert] = "Game over! Better luck next time."
    end

    render :index
  end
end
