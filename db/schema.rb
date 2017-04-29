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

ActiveRecord::Schema.define(version: 20170419221133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.string   "credit_union",    limit: 255
    t.date     "date_activity"
    t.string   "type_of_expense", limit: 255
    t.float    "amount"
    t.string   "notes",           limit: 255
    t.string   "filename",        limit: 255
    t.string   "content_type",    limit: 255
    t.string   "department",      limit: 255
    t.string   "approval",        limit: 255
    t.binary   "file_contents"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meal_type",       limit: 255
    t.string   "submitted",       limit: 255
    t.string   "approval_final",  limit: 255
    t.float    "miles_traveled"
    t.float    "mileage_expense"
    t.float    "air_travel"
    t.float    "taxi_parking"
    t.float    "car_rental"
    t.float    "lodging"
    t.float    "entertainment"
    t.float    "other"
    t.float    "total"
    t.string   "job"
    t.json     "images"
    t.float    "meal_total"
    t.json     "meal_names"
    t.json     "meals"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installs", force: :cascade do |t|
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
    t.index ["email"], name: "index_installs_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true, using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.boolean  "done"
    t.integer  "todo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_id"], name: "index_items_on_todo_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "credit_union",    limit: 255
    t.string   "activity",        limit: 255
    t.string   "task",            limit: 255
    t.string   "billing_options", limit: 255
    t.string   "sunnotes",        limit: 255
    t.string   "monnotes",        limit: 255
    t.float    "sun"
    t.float    "mon"
    t.float    "tue"
    t.float    "wed"
    t.float    "thu"
    t.float    "fri"
    t.float    "sat"
    t.float    "total"
    t.string   "approval",        limit: 255
    t.date     "date_of_time"
    t.string   "department",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tuenotes",        limit: 255
    t.string   "wednotes",        limit: 255
    t.string   "thunotes",        limit: 255
    t.string   "frinotes",        limit: 255
    t.string   "satnotes",        limit: 255
    t.string   "submitted",       limit: 255
    t.index ["user_id", "created_at"], name: "index_pages_on_user_id_and_created_at", using: :btree
  end

  create_table "todos", force: :cascade do |t|
    t.string   "title"
    t.string   "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "department",             limit: 255
    t.boolean  "admin",                              default: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "profile",                limit: 255
    t.boolean  "superadmin",                         default: false
    t.date     "lastemailed"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "items", "todos"
end
