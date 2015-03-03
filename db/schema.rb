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

ActiveRecord::Schema.define(version: 20150303155855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "park_photos", force: :cascade do |t|
    t.integer  "park_id",       null: false
    t.integer  "post_photo_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "park_photos", ["park_id"], name: "index_park_photos_on_park_id", using: :btree
  add_index "park_photos", ["post_photo_id"], name: "index_park_photos_on_post_photo_id", using: :btree

  create_table "parks", force: :cascade do |t|
    t.string    "name",       limit: 255,                                              null: false
    t.geography "geog",       limit: {:srid=>4326, :type=>"point", :geographic=>true}, null: false
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  create_table "post_photos", force: :cascade do |t|
    t.string    "photo",           limit: 255,                                              null: false
    t.float     "image_direction",                                                          null: false
    t.text      "note",                                                                     null: false
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.geography "geog",            limit: {:srid=>4326, :type=>"point", :geographic=>true}, null: false
  end

end
