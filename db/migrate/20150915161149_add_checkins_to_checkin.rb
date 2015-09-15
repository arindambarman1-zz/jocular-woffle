class AddCheckinsToCheckin < ActiveRecord::Migration
  def change
  	add_column :checkins, :checkins, :bigint
  end
end