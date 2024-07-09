# lib/tasks/population_scraper.rake
namespace :population do
  desc 'Fetch population data from Worldometers'
  task fetch: :environment do
    require 'open-uri'
    require 'nokogiri'

    url = 'https://www.worldometers.info/world-population/population-by-country/'
    page = Nokogiri::HTML(URI.open(url))

    # Assuming the population data is in a table with id 'example2'
    table = page.css('#example2')

    table.css('tr').each do |row|
      # Extract country name and population
      country_name = row.css('td')[1]&.text&.strip
      population = row.css('td')[2]&.text&.strip&.gsub(',', '')&.to_i

      if country_name.present? && population.positive?
        CountryPopulation.find_or_create_by(country_name: country_name) do |country|
          country.population = population
        end
      end
    end

    puts 'Population data updated successfully.'
  end
end
