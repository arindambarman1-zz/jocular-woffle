class AddBusinessIdToCheckin < ActiveRecord::Migration
  def change
  	add_column :checkins, :business_id, :bigint
  end
end
