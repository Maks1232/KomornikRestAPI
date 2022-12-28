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

ActiveRecord::Schema[7.0].define(version: 2022_12_28_222500) do
  create_table "bills", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.decimal "amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ispaid", default: false
    t.bigint "user_id", null: false
    t.bigint "commitment_id", null: false
    t.index ["commitment_id"], name: "index_bills_on_commitment_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "commitments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "commitmentdesc", limit: 64
    t.decimal "commitmentamount", precision: 10
    t.date "occurancedate"
    t.date "expirationdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "groupinfo_id", null: false
    t.index ["groupinfo_id"], name: "index_commitments_on_groupinfo_id"
    t.index ["user_id"], name: "index_commitments_on_user_id"
  end

  create_table "groupinfos", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "groupname", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groupinfos_users", id: false, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "groupinfo_id", null: false
    t.bigint "user_id", null: false
    t.index ["groupinfo_id", "user_id"], name: "index_groupinfos_users_on_groupinfo_id_and_user_id"
    t.index ["user_id", "groupinfo_id"], name: "index_groupinfos_users_on_user_id_and_groupinfo_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "firstname", limit: 32
    t.string "lastname", limit: 32
    t.string "login", null: false
    t.string "password_digest", null: false
    t.string "mail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bills", "commitments", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bills", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "commitments", "groupinfos", on_update: :cascade, on_delete: :cascade
  add_foreign_key "commitments", "users", on_update: :cascade, on_delete: :cascade
end
