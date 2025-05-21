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

ActiveRecord::Schema[8.0].define(version: 2025_05_21_012856) do
  create_table "carts", force: :cascade do |t|
    t.integer "status"
    t.float "total_price", default: 0.0
    t.float "fee", default: 0.0
    t.float "discount", default: 0.0
    t.integer "order_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "actual_price", precision: 10, scale: 2
    t.index ["order_id"], name: "index_carts_on_order_id"
    t.index ["user_id", "status"], name: "index_carts_on_user_id_and_status"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_inventories_on_product_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.float "unit_price"
    t.float "total"
    t.integer "cart_id"
    t.decimal "actual_price", precision: 10, scale: 2
    t.index ["cart_id"], name: "index_order_details_on_cart_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_id"
    t.string "amount"
    t.integer "status"
    t.integer "user_id", null: false
    t.datetime "ordered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "service_fee"
    t.float "discount"
    t.integer "payment_id"
    t.decimal "actual_price", precision: 10, scale: 2
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "category_id", null: false
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "address"
    t.string "phone_number"
    t.integer "user_id"
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "role"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "carts", "orders"
  add_foreign_key "carts", "users"
  add_foreign_key "inventories", "products"
  add_foreign_key "order_details", "carts"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "sessions", "users"
  add_foreign_key "suppliers", "users"
end
