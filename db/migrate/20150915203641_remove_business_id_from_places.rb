class RemoveBusinessIdFromPlaces < ActiveRecord::Migration
  def change
  	remove_column :places, :business_id
  end
end
