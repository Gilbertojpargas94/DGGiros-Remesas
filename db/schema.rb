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

ActiveRecord::Schema.define(version: 2018_12_20_193254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "headline", default: "", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "order", null: false
    t.float "amount", default: 0.0, null: false
    t.float "rate", default: 0.0, null: false
    t.string "account", default: "", null: false
    t.string "country", default: "", null: false
    t.string "bank", default: "", null: false
    t.string "headline_account", default: "", null: false
    t.string "id_account", default: ""
    t.string "gmail_account", default: ""
    t.string "status", default: "Esperando Comprobante", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_file_name"
    t.string "payment_content_type"
    t.integer "payment_file_size"
    t.datetime "payment_updated_at"
    t.string "gmail_user", default: ""
    t.string "name_user", default: ""
    t.string "address_user"
    t.string "dni_user"
    t.string "phone_user"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.string "country", default: "", null: false
    t.float "value", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "type_person", default: "normal", null: false
    t.string "name", default: "", null: false
    t.string "phone", default: ""
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "dni"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "quotations", "users"
end
