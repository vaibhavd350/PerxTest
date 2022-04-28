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

ActiveRecord::Schema.define(version: 2022_04_26_163258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "business_type"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points_logs", force: :cascade do |t|
    t.integer "points_earned"
    t.bigint "user_id"
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issued_by"
    t.index ["user_id"], name: "index_points_logs_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "reward_type"
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "user_client_transactions", force: :cascade do |t|
    t.string "currency"
    t.decimal "amount"
    t.bigint "client_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_user_client_transactions_on_client_id"
    t.index ["user_id"], name: "index_user_client_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "loyalty_tier"
    t.string "currency"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "points_logs", "clients", column: "issued_by"
  add_foreign_key "points_logs", "users"
  add_foreign_key "rewards", "users"
  add_foreign_key "user_client_transactions", "clients"
  add_foreign_key "user_client_transactions", "users"
end
