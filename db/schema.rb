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

ActiveRecord::Schema.define(version: 20131227021712) do

  create_table "action_logs", force: true do |t|
    t.integer  "log_type"
    t.integer  "user_id"
    t.string   "target_user"
    t.string   "do_user"
    t.string   "information", limit: 2048
    t.string   "description", limit: 2048
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "do_user_id"
  end

  add_index "action_logs", ["updated_at"], name: "index_action_logs_on_updated_at", using: :btree
  add_index "action_logs", ["user_id"], name: "index_action_logs_on_user_id", using: :btree

  create_table "game_clienter_relations", force: true do |t|
    t.integer "game_id"
    t.integer "game_clienter_id"
  end

  create_table "game_clienters", force: true do |t|
    t.string   "game_clienter_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_launcher_relations", force: true do |t|
    t.integer "game_id"
    t.integer "game_launcher_id"
  end

  create_table "game_launchers", force: true do |t|
    t.string "game_launcher_name"
  end

  create_table "games", force: true do |t|
    t.string   "game_name"
    t.string   "initial"
    t.string   "game_alias"
    t.integer  "server_region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "email"
    t.string   "user_id"
    t.string   "order_id"
    t.integer  "status",                                    default: 0
    t.string   "receiver"
    t.decimal  "amount",            precision: 8, scale: 2
    t.decimal  "balance",           precision: 8, scale: 2
    t.integer  "days"
    t.integer  "game_id"
    t.integer  "product_id"
    t.string   "lottery_code"
    t.string   "coupon"
    t.string   "pay_bank"
    t.integer  "card_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "pay_at"
    t.string   "third_party_order"
    t.string   "pay_type",                                  default: ""
  end

  add_index "orders", ["order_id"], name: "index_order_id", using: :btree
  add_index "orders", ["updated_at"], name: "index_updated_at", using: :btree

  create_table "server_regions", force: true do |t|
    t.string "server_region_name"
  end

  create_table "servers", force: true do |t|
    t.string  "server_name"
    t.integer "server_region_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "comment_mode"
    t.integer  "comment_sort"
    t.string   "theme"
    t.string   "signature"
    t.string   "signature_format"
    t.integer  "status"
    t.string   "timezone"
    t.string   "language"
    t.string   "picture"
    t.string   "init_email"
    t.text     "data"
    t.string   "phone"
    t.string   "qq"
    t.date     "expire_date"
    t.integer  "expire_days"
    t.datetime "expire_time"
    t.integer  "introducer"
    t.string   "invite_token"
    t.integer  "is_verify_email"
    t.integer  "is_buy"
    t.decimal  "money",                  precision: 8, scale: 2
    t.string   "game_type"
    t.integer  "is_pause"
    t.datetime "pause_time"
    t.integer  "is_mac"
    t.integer  "login_success_times"
    t.integer  "login_fail_times"
    t.integer  "allow_client_number"
    t.integer  "is_blocked"
    t.string   "register_source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                          default: "", null: false
    t.string   "reset_password_token"
    t.string   "encrypted_password",                                          null: false
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.integer  "type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
