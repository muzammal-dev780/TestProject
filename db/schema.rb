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

ActiveRecord::Schema.define(version: 2020_09_21_152248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "unit_price"
    t.integer "max_unit_limit"
    t.bigint "plan_id"
    t.datetime "created_at", default: "2020-09-22 15:04:54"
    t.datetime "updated_at", default: "2020-09-22 15:04:54"
    t.index ["plan_id"], name: "index_features_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "fee"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.integer "bill_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.integer "total_charges"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_transactions_on_subscription_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "usages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.bigint "subscription_id"
    t.integer "units_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "feature_id"
    t.index ["plan_id"], name: "index_usages_on_plan_id"
    t.index ["subscription_id", "feature_id"], name: "index_usages_on_subscription_id_and_feature_id", unique: true
    t.index ["subscription_id"], name: "index_usages_on_subscription_id"
    t.index ["user_id"], name: "index_usages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "features", "plans"
  add_foreign_key "plans", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "transactions", "subscriptions"
  add_foreign_key "transactions", "users"
  add_foreign_key "usages", "plans"
  add_foreign_key "usages", "subscriptions"
  add_foreign_key "usages", "users"
end
