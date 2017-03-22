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

ActiveRecord::Schema.define(version: 20170315210557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: true do |t|
    t.string   "credit_union"
    t.date     "date_activity"
    t.string   "type_of_expense"
    t.float    "amount"
    t.string   "notes"
    t.string   "filename"
    t.string   "content_type"
    t.string   "department"
    t.string   "approval"
    t.string   "image"
    t.binary   "file_contents"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meal_type"
    t.string   "submitted"
    t.string   "approvalFinal"
  end

  create_table "pages", force: true do |t|
    t.string   "credit_union"
    t.string   "activity"
    t.string   "task"
    t.string   "billing_options"
    t.string   "sunnotes"
    t.string   "monnotes"
    t.float    "sun"
    t.float    "mon"
    t.float    "tue"
    t.float    "wed"
    t.float    "thu"
    t.float    "fri"
    t.float    "sat"
    t.float    "total"
    t.string   "approval"
    t.date     "date_of_time"
    t.string   "department"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tuenotes"
    t.string   "wednotes"
    t.string   "thunotes"
    t.string   "frinotes"
    t.string   "satnotes"
    t.string   "submitted"
  end

  add_index "pages", ["user_id", "created_at"], name: "index_pages_on_user_id_and_created_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "department"
    t.boolean  "admin",                  default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "profile"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
