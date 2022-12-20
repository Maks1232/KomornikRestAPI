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

ActiveRecord::Schema[7.0].define(version: 2022_12_20_155220) do
  create_table "bills", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.decimal "amount", precision: 10
    t.string "ispaid", limit: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commitments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "commitmentdesc", limit: 64
    t.decimal "commitmentamount", precision: 10
    t.date "occurancedate"
    t.date "expirationdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groupinfos", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "groupname", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usergroups", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "firstname", limit: 32
    t.string "lastname", limit: 32
    t.string "login", limit: 15
    t.string "password", limit: 32
    t.string "mail", limit: 32
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
