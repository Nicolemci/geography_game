class CreateCountryAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :country_areas do |t|
      t.string :country_name
      t.integer :area

      t.timestamps
    end
  end
end
