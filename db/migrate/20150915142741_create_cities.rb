class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :min_lat
      t.string :max_lat
      t.string :min_long
      t.string :max_long

      t.timestamps null: false
    end
  end
end
