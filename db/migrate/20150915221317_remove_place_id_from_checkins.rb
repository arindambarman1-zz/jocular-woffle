class RemovePlaceIdFromCheckins < ActiveRecord::Migration
  def change
  	remove_column :checkins, :place_id
  end
end
