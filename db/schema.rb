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

ActiveRecord::Schema.define(version: 2020_12_19_171427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "program_users", force: :cascade do |t|
    t.bigint "program_id", null: false
    t.bigint "user_id", null: false
    t.boolean "bookmark"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_program_users_on_program_id"
    t.index ["user_id"], name: "index_program_users_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name", null: false
    t.string "accreditation_id", null: false
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "program_director_name"
    t.string "phone"
    t.string "email"
    t.boolean "non_caribbean_img_friendly"
    t.boolean "caribbean_img_friendly"
    t.boolean "j1_visa"
    t.boolean "h1_visa"
    t.boolean "us_clinical_experience"
    t.integer "minimum_step_1_score"
    t.integer "minimum_step_2ck_score"
    t.string "step_1_notes"
    t.string "step_2ck_notes"
    t.boolean "step_1_failure"
    t.boolean "step_2ck_failure"
    t.boolean "step_2cs_failure"
    t.integer "years_since_graduation"
    t.string "notes"
    t.string "website"
    t.integer "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enabled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "img_type", null: false
    t.integer "step_1_score", null: false
    t.boolean "step_1_fail"
    t.integer "step_2ck_score"
    t.boolean "step_2ck_fail"
    t.boolean "us_clinical_experience", null: false
    t.integer "years_since_graduation", null: false
    t.integer "visa", null: false
    t.integer "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
