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

ActiveRecord::Schema.define(version: 20161214163524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignment_versions", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "week"
    t.text     "question"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "youtube_id"
    t.string   "title"
    t.integer  "assignment_version_id"
    t.boolean  "attachment"
    t.integer  "assignment_order"
  end

  create_table "cohorts", force: :cascade do |t|
    t.integer  "instructor_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "start_date"
    t.integer  "location_id"
    t.string   "nickname"
    t.integer  "assignment_version_id"
    t.string   "gmail_calendar"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "assignment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "student_id"
    t.boolean  "viewed_by_admin"
  end

  create_table "grades", force: :cascade do |t|
    t.string   "letter"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "week"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.text     "answer"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "solution"
    t.boolean  "viewed_by_admin"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.integer  "cohort_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
