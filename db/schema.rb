# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_11_211100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credentials", force: :cascade do |t|
    t.string "body"
    t.string "code"
    t.integer "type", default: 0
    t.integer "status", default: 0
    t.string "dni_user"
    t.string "email_user"
    t.date "expiration_at"
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_credentials_on_event_id"
    t.index ["user_id"], name: "index_credentials_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.decimal "minimum_score"
    t.date "date_programmed"
    t.integer "organizations_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "institution_events", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_institution_events_on_event_id"
    t.index ["user_id"], name: "index_institution_events_on_user_id"
  end

  create_table "score_users", force: :cascade do |t|
    t.decimal "score"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_score_users_on_event_id"
    t.index ["user_id"], name: "index_score_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "last_name"
    t.string "nickname"
    t.string "dni"
    t.string "image"
    t.string "email"
    t.integer "role", default: 0
    t.string "web"
    t.string "description"
    t.string "phone"
    t.integer "credentials_count", default: 0
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "credentials", "events"
  add_foreign_key "credentials", "users"
  add_foreign_key "institution_events", "events"
  add_foreign_key "institution_events", "users"
  add_foreign_key "score_users", "events"
  add_foreign_key "score_users", "users"
end
