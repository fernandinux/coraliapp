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

ActiveRecord::Schema.define(version: 2020_08_13_044109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credentials", force: :cascade do |t|
    t.string "body"
    t.integer "credential_id"
    t.string "credential_type"
    t.string "status"
    t.integer "dni_user"
    t.date "expiration_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "credentialable_type"
    t.bigint "credentialable_id"
    t.string "email_user"
    t.index ["credentialable_type", "credentialable_id"], name: "index_credentials_on_credentialable_type_and_credentialable_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "minimum_score"
    t.integer "organizations_count"
  end

  create_table "organization_events", force: :cascade do |t|
    t.integer "event_id"
    t.integer "organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "organiable_type"
    t.bigint "organiable_id"
    t.index ["organiable_type", "organiable_id"], name: "index_organizations_on_organiable_type_and_organiable_id"
  end

  create_table "score_users", force: :cascade do |t|
    t.integer "score"
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name"
    t.integer "dni"
    t.integer "credentials_count"
  end

end
