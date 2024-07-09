class CreateCountryPopulations < ActiveRecord::Migration[7.1]
  def change
    create_table :country_populations do |t|
      t.string :country_name
      t.integer :population

      t.timestamps
    end
  end
end
