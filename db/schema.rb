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

ActiveRecord::Schema[8.0].define(version: 2025_02_24_000000) do
  create_table "project_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_comments_on_project_id"
    t.index ["user_id"], name: "index_project_comments_on_user_id"
  end

  create_table "project_events", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "eventable_type", null: false
    t.integer "eventable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_type", "eventable_id"], name: "index_project_events_on_eventable"
    t.index ["project_id", "created_at"], name: "index_project_events_on_project_id_and_created_at"
    t.index ["project_id"], name: "index_project_events_on_project_id"
  end

  create_table "project_status_changes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "from_status", null: false
    t.string "to_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_status_changes_on_project_id"
    t.index ["user_id"], name: "index_project_status_changes_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "github_username"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "project_comments", "projects"
  add_foreign_key "project_comments", "users"
  add_foreign_key "project_events", "projects"
  add_foreign_key "project_status_changes", "projects"
  add_foreign_key "project_status_changes", "users"
  add_foreign_key "sessions", "users"
end
