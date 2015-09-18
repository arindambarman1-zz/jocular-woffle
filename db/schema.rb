# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150918131816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", primary_key: "business_id", force: :cascade do |t|
    t.string   "business_name"
    t.string   "cat_name"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "city_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "businesses", ["city_id"], name: "index_businesses_on_city_id", using: :btree

  create_table "checkins", force: :cascade do |t|
    t.integer  "checkins"
    t.integer  "business_id", limit: 8
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "checkins", ["business_id"], name: "index_checkins_on_business_id", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "min_lat"
    t.string   "max_lat"
    t.string   "min_long"
    t.string   "max_long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "checkins", "businesses", primary_key: "business_id", name: "checkinfk"
end
