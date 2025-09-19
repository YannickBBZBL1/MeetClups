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

ActiveRecord::Schema[8.0].define(version: 2025_09_19_120235) do
  create_table "club_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "club_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_memberships_on_club_id"
    t.index ["user_id"], name: "index_club_memberships_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_clubs_on_title", unique: true
  end

  create_table "meetup_participants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "meetup_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetup_id"], name: "index_meetup_participants_on_meetup_id"
    t.index ["user_id"], name: "index_meetup_participants_on_user_id"
  end

  create_table "meetups", force: :cascade do |t|
    t.string "title"
    t.string "subject"
    t.datetime "datetime"
    t.string "location"
    t.integer "max_participants", default: 0
    t.integer "organizer_id"
    t.integer "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "username", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "club_memberships", "clubs"
  add_foreign_key "club_memberships", "users"
  add_foreign_key "meetup_participants", "meetups"
  add_foreign_key "meetup_participants", "users"
  add_foreign_key "sessions", "users"
end
