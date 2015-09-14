class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :business_name
      t.string :cat_name
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
