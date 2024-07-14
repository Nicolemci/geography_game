class GameController < ApplicationController
  def population
    @title = 'Population'
    @countries = CountryPopulation.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_population_order
    check_order('population')
  end

  def area
    @title = 'Area'
    @countries = CountryArea.order('RANDOM()').limit(10)
    @turns_left = 5
  end

  def check_area_order
    check_order('area')
  end

  def random
    fetch_random_topic
    @turns_left = 5

    case @topic
    when 'population'
      @title = 'Population'
      @countries = CountryPopulation.order('RANDOM()').limit(10)
    when 'area'
      @title = 'Area'
      @countries = CountryArea.order('RANDOM()').limit(10)
    end
  end

  def check_random_order
    check_order(@topic)
  end

  private

  def check_order(topic)
    selected_country_ids = params[:countries]
    selected_country_ids = selected_country_ids.is_a?(String) ? selected_country_ids.split(',') : selected_country_ids
    @turns_left = params[:turns_left].to_i - 1

    @correct = case topic
               when 'population'
                 selected_country_ids.each_cons(2).all? do |a, b|
                   CountryPopulation.find(a).population <= CountryPopulation.find(b).population
                 end
               when 'area'
                 selected_country_ids.each_cons(2).all? do |a, b|
                   CountryArea.find(a).area <= CountryArea.find(b).area
                 end
               end

    if @correct
      flash[:notice] = "Correct! You have successfully ranked the countries by #{topic}."
      redirect_to root_path
    elsif @turns_left.zero?
      flash[:alert] = "Game over! You have used all your turns."
      redirect_to root_path
    else
      @countries = case topic
                   when 'population'
                     CountryPopulation.find(selected_country_ids)
                   when 'area'
                     CountryArea.find(selected_country_ids)
                   end
      @title = topic.capitalize
      render :random
    end
  end

  def fetch_random_topic
    base_url = 'https://www.worldometers.info/'
    page = Nokogiri::HTML(URI.open(base_url))

    topic_links = page.css('a').select { |link| link['href'] =~ /worldometers.info/ }
    topic_links = topic_links.map { |link| link['href'] }.uniq

    relevant_topics = topic_links.select do |link|
      link.include?('population') || link.include?('geography')
    end

    selected_topic_url = relevant_topics.sample

    if selected_topic_url.include?('population')
      @topic = 'population'
    elsif selected_topic_url.include?('geography')
      @topic = 'area'
    end
  end
end
