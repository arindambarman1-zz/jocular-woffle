class AddCheckinsToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :checkins, :bigint
  end
end
