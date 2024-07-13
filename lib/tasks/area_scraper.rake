namespace :area do
  desc 'Fetch area data from Worldometers'
  task fetch: :environment do
    require 'open-uri'
    require 'nokogiri'

    url = 'https://www.worldometers.info/geography/largest-countries-in-the-world/'
    page = Nokogiri::HTML(URI.open(url))

    # Assuming the area data is in a table with id 'example2'
    table = page.css('table')[0] # Adjust this selector based on the actual table in the webpage

    table.css('tr').each do |row|
      # Extract country name and area
      country_name = row.css('td')[1]&.text&.strip
      area = row.css('td')[2]&.text&.strip&.gsub(',', '')&.to_i

      if country_name.present? && area.positive?
        CountryArea.find_or_create_by(country_name: country_name) do |country|
          country.area = area
        end
      end
    end

    puts 'Area data updated successfully.'
  end
end
