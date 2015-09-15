class AddIndexToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :business_id, :bigint
    add_index :places, :business_id, unique: true
  end
end
