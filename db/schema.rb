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

ActiveRecord::Schema.define(version: 20160409152811) do

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.integer  "year"
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true

  create_table "layer_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  add_index "notes", ["name"], name: "index_notes_on_name", unique: true

  create_table "perfume_notes", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "perfume_id"
    t.integer  "note_id"
    t.integer  "layer_type_id"
  end

  add_index "perfume_notes", ["perfume_id", "note_id", "layer_type_id"], name: "index_perfume_notes_constraint", unique: true

  create_table "perfumes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year"
    t.string   "name",       null: false
    t.integer  "brand_id",   null: false
  end

  add_index "perfumes", ["name", "brand_id"], name: "index_perfumes_on_name_and_brand_id", unique: true

end
