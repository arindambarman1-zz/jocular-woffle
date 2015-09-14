class AddBusinessIdToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :business_id, :bigint
  end
end
