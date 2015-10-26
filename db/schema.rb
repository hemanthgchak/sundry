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

ActiveRecord::Schema.define(version: 20151001081747) do

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "category"
    t.string   "subcategory"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "denizens", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "dweller_type"
    t.integer  "dweller_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "locations", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "street"
    t.string   "address"
    t.integer  "pincode"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "url"
    t.string   "place_id"
    t.string   "attribution"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "photo_reference"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_no"
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "street_no"
    t.string   "route"
    t.string   "nb"
    t.string   "sl_3"
    t.string   "sl_2"
    t.string   "sl_1"
    t.string   "locality"
    t.string   "aal_2"
    t.string   "aal_1"
    t.string   "country"
    t.string   "pincode"
    t.string   "place_id"
    t.string   "types"
    t.string   "photoreference"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "radar_searches", force: :cascade do |t|
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "g_id"
    t.string   "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
