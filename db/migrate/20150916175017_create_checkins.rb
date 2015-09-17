class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :checkins
      t.bigint :business_id

      t.timestamps null: false
    end
    add_index :checkins, :business_id, unique: true
    execute 'ALTER TABLE "checkins" ADD CONSTRAINT checkinfk FOREIGN KEY
    ("business_id") REFERENCES "businesses" ("business_id") MATCH FULL;'
  end
end
