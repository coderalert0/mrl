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

ActiveRecord::Schema.define(version: 2021_03_01_212745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

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
    t.string "address"
    t.string "acgme_program_code", null: false
    t.string "website"
    t.string "phone"
    t.string "email"
    t.string "program_coordinator"
    t.string "program_coordinator_email"
    t.string "program_director"
    t.integer "minimum_step_1_score"
    t.string "step_2_required"
    t.integer "minimum_step_2_score"
    t.string "j_1_sponsorship_through_ecfmg"
    t.string "h1_b"
    t.string "f_1"
    t.string "must_pass_step_2_cs_first_attempt"
    t.integer "us_md_graduates"
    t.integer "us_do_graduates"
    t.integer "non_us_citizen_international_medical_graduates"
    t.integer "us_citizen_international_medical_graduates"
    t.boolean "us_clinical_experience"
    t.integer "years_since_graduation"
    t.string "notes"
    t.integer "active"
    t.bigint "speciality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_programs_on_slug", unique: true
    t.index ["speciality_id"], name: "index_programs_on_speciality_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active"
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
    t.integer "step_2ck_score"
    t.boolean "step_1_fail"
    t.boolean "step_2ck_fail"
    t.boolean "step_2cs_fail"
    t.boolean "us_clinical_experience"
    t.integer "years_since_graduation", null: false
    t.integer "visa", null: false
    t.integer "admin"
    t.boolean "paid"
    t.boolean "cancelled"
    t.index ["email"], name: "index_users_on_email"
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
