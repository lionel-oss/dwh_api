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

ActiveRecord::Schema.define(version: 2019_09_23_152704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_level_endpoints", force: :cascade do |t|
    t.bigint "access_level_id"
    t.bigint "endpoint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_level_id", "endpoint_id"], name: "index_access_level_endpoints_on_access_level_id_and_endpoint_id", unique: true
  end

  create_table "access_levels", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "database_credentials", force: :cascade do |t|
    t.string "user", null: false
    t.string "password", null: false
    t.string "database", null: false
    t.string "host", null: false
    t.string "port", null: false
    t.string "salt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "endpoints", force: :cascade do |t|
    t.text "query", null: false
    t.bigint "database_credential_id", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["database_credential_id"], name: "index_endpoints_on_database_credential_id"
  end

  create_table "request_logs", force: :cascade do |t|
    t.string "endpoint", null: false
    t.string "token", null: false
    t.string "status", null: false
    t.string "http_protocol", null: false
    t.float "db_duration", null: false
    t.float "total_duration", null: false
    t.string "error_message"
    t.string "server_name"
    t.jsonb "params", default: "{}", null: false
    t.inet "ip_address", null: false
    t.boolean "email_sended", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "access_level_id"
    t.index ["access_level_id"], name: "index_tokens_on_access_level_id"
    t.index ["code"], name: "index_tokens_on_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", default: ""
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
