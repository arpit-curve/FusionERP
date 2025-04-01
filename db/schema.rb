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

ActiveRecord::Schema[8.0].define(version: 2025_04_01_115358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  create_table "blacklisted_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_blacklisted_tokens_on_token"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_head_id"
    t.index ["department_head_id"], name: "index_departments_on_department_head_id"
    t.index ["organization_id"], name: "index_departments_on_organization_id"
  end

  create_table "designations", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_designations_on_department_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "admin_email"
    t.boolean "is_deleted"
    t.integer "deleted_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
    t.index ["organization_id"], name: "index_roles_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "dob"
    t.datetime "doj"
    t.string "employee_id"
    t.string "gender"
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "deleted_at"
    t.integer "deleted_by"
    t.bigint "organization_id", null: false
    t.bigint "manager_id"
    t.bigint "hr_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.bigint "designation_id", null: false
    t.index ["designation_id"], name: "index_users_on_designation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hr_id"], name: "index_users_on_hr_id"
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "departments", "organizations"
  add_foreign_key "designations", "departments"
  add_foreign_key "roles", "organizations"
  add_foreign_key "users", "designations"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "users", column: "hr_id"
  add_foreign_key "users", "users", column: "manager_id"
end
