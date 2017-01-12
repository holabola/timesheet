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

ActiveRecord::Schema.define(version: 20161213155901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: true do |t|
    t.string   "credit_union"
    t.date     "date_activity"
    t.string   "type_of_expense"
    t.float    "amount"
    t.string   "payment"
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
  end

  create_table "pages", force: true do |t|
    t.string   "credit_union"
    t.string   "activity"
    t.string   "task"
    t.string   "billing_options"
    t.string   "billing_options_scr"
    t.string   "billing_options_ftr"
    t.integer  "sun"
    t.integer  "mon"
    t.integer  "tue"
    t.integer  "wed"
    t.integer  "thu"
    t.integer  "fri"
    t.integer  "sat"
    t.integer  "total"
    t.string   "approval"
    t.string   "date_of_time"
    t.string   "department"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
