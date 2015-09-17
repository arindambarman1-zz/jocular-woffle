class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses, id: false do |t|
      t.bigint :business_id, null: false
      t.string :business_name
      t.string :cat_name
      t.string :latitude
      t.string :longitude
      t.belongs_to :city, index: true, null: false

      t.timestamps null: false
    end
    execute 'ALTER TABLE "businesses" ADD PRIMARY KEY ("business_id");'
  end
end
