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

ActiveRecord::Schema.define(version: 2018_09_10_200902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "parent_id"
    t.integer "set_id"
    t.string "name", null: false
    t.decimal "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_categories_on_product_id"
  end

  create_table "page_requests", force: :cascade do |t|
    t.bigint "product_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "asin"
    t.integer "status"
    t.index ["product_id"], name: "index_page_requests_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "asin", null: false
    t.decimal "length"
    t.decimal "width"
    t.decimal "height"
    t.string "dimensions_units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asin"], name: "index_products_on_asin", unique: true
  end

  add_foreign_key "page_requests", "products"
end
