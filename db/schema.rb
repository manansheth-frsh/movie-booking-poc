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

ActiveRecord::Schema.define(version: 2025_10_24_072645) do

  create_table "audit_logs", force: :cascade do |t|
    t.string "action"
    t.string "record_type"
    t.integer "record_id"
    t.integer "user_id"
    t.json "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "show_id", null: false
    t.integer "seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["show_id"], name: "index_bookings_on_show_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "language"
    t.date "release_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shows", force: :cascade do |t|
    t.integer "slot", null: false
    t.date "date", null: false
    t.integer "current_available_bookings", null: false
    t.integer "movie_id", null: false
    t.integer "theatre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["theatre_id", "slot", "date"], name: "unique_theatre_slot_date", unique: true
    t.index ["theatre_id"], name: "index_shows_on_theatre_id"
  end

  create_table "theatres", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin"
  end

  add_foreign_key "bookings", "shows", on_delete: :cascade
  add_foreign_key "bookings", "users"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "theatres"
end
