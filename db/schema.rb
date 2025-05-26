# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_05_26_075334) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "maps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "permission", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_maps_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_memberships_on_map_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "pins", force: :cascade do |t|
    t.string "label"
    t.bigint "place_id", null: false
    t.bigint "map_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_pins_on_map_id"
    t.index ["place_id"], name: "index_pins_on_place_id"
    t.index ["user_id"], name: "index_pins_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.string "opening_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.string "title"
    t.integer "recommended", default: 0
    t.bigint "pin_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pin_id"], name: "index_reviews_on_pin_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "maps", "users"
  add_foreign_key "memberships", "maps"
  add_foreign_key "memberships", "users"
  add_foreign_key "pins", "maps"
  add_foreign_key "pins", "places"
  add_foreign_key "pins", "users"
  add_foreign_key "reviews", "pins"
  add_foreign_key "reviews", "users"
end
