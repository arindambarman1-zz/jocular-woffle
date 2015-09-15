class AddCityToPlaces < ActiveRecord::Migration
  def change
    add_reference :places, :city, index: true, foreign_key: true
  end
end
