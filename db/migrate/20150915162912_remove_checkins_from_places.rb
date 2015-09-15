class RemoveCheckinsFromPlaces < ActiveRecord::Migration
  def change
  	remove_column :places, :checkins 
  end
end
