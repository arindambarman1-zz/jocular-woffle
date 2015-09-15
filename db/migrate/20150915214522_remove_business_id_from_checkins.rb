class RemoveBusinessIdFromCheckins < ActiveRecord::Migration
  def change
  	remove_column :checkins, :business_id
  end
end
