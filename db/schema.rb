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

ActiveRecord::Schema[7.0].define(version: 2024_06_12_083409) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "admin_name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credits", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credits_on_user_id"
  end

  create_table "mejiro_coin_transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "spend_amount"
    t.string "product_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "product"
    t.date "date"
    t.decimal "spend"
    t.time "time"
    t.index ["user_id"], name: "index_mejiro_coin_transactions_on_user_id"
  end

  create_table "membership_logs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "membership_id"
    t.integer "amount"
    t.integer "total_cost"
    t.string "operation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.integer "category_id", null: false
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.integer "days_of_membership"
    t.integer "user_id"
    t.integer "membership_days_remaining"
    t.index ["category_id"], name: "index_memberships_on_category_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.boolean "in_stock"
    t.string "price_currency"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "product_id"
    t.string "product_name"
    t.float "product_price"
    t.string "product_category"
    t.integer "user_id"
    t.float "user_post_balance"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "credit_amount"
  end

  create_table "top_ups", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents"
    t.string "amount_currency"
    t.string "checkout_session_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_top_ups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "membership_days"
    t.date "last_membership_start_date"
    t.integer "membership_id"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["membership_id"], name: "index_users_on_membership_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "whatsapp_numbers", force: :cascade do |t|
    t.string "number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_whatsapp_numbers_on_user_id"
  end

  add_foreign_key "credits", "users"
  add_foreign_key "mejiro_coin_transactions", "users"
  add_foreign_key "memberships", "categories"
  add_foreign_key "memberships", "users"
  add_foreign_key "top_ups", "users"
  add_foreign_key "users", "memberships"
  add_foreign_key "whatsapp_numbers", "users"
end
