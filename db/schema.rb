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

ActiveRecord::Schema.define(version: 20150504010657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inks", force: :cascade do |t|
    t.string   "brand"
    t.string   "short_description"
    t.text     "long_description"
    t.float    "price"
    t.string   "unit"
    t.string   "sku"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "image_url"
  end

  create_table "printer_inks", force: :cascade do |t|
    t.integer  "printer_id"
    t.integer  "ink_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printers", force: :cascade do |t|
    t.string   "brand"
    t.string   "model"
    t.string   "printer_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "url"
    t.integer  "level"
  end

  add_index "product_categories", ["product_type_id"], name: "index_product_categories_on_product_type_id", using: :btree

  create_table "product_item_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "product_item_types", ["product_category_id"], name: "index_product_item_types_on_product_category_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.string   "unit"
    t.string   "brand"
    t.integer  "cat_level_1"
    t.integer  "cat_level_2"
    t.integer  "cat_level_3"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_url"
  end

  add_foreign_key "product_categories", "product_types"
  add_foreign_key "product_item_types", "product_categories"
end
