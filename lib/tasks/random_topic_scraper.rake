namespace :random_topic do
  desc 'Fetch a random topic data from Worldometers'
  task fetch: :environment do
    require 'open-uri'
    require 'nokogiri'

    base_url = 'https://www.worldometers.info/'
    page = Nokogiri::HTML(URI.open(base_url))

    # Fetch the links to different topics
    topic_links = page.css('a').select { |link| link['href'] =~ /worldometers.info/ }
    topic_links = topic_links.map { |link| link['href'] }.uniq

    # Filter links to include only relevant topics
    relevant_topics = topic_links.select do |link|
      link.include?('population') || link.include?('geography')
    end

    # Select a random topic
    selected_topic_url = relevant_topics.sample
    topic_page = Nokogiri::HTML(URI.open(selected_topic_url))

    case selected_topic_url
    when /population/
      topic_name = 'population'
      table = topic_page.css('#example2')
      table.css('tr').each do |row|
        country_name = row.css('td')[1]&.text&.strip
        population = row.css('td')[2]&.text&.strip&.gsub(',', '')&.to_i

        if country_name.present? && population.positive?
          CountryPopulation.find_or_create_by(country_name: country_name) do |country|
            country.population = population
          end
        end
      end
    when /geography/
      topic_name = 'area'
      table = topic_page.css('table')[0]
      table.css('tr').each do |row|
        country_name = row.css('td')[1]&.text&.strip
        area = row.css('td')[2]&.text&.strip&.gsub(',', '')&.to_i

        if country_name.present? && area.positive?
          CountryArea.find_or_create_by(country_name: country_name) do |country|
            country.area = area
          end
        end
      end
    end

    puts "#{topic_name.capitalize} data updated successfully."
  end
end
