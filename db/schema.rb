# frozen_string_literal: true

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

ActiveRecord::Schema[8.0].define(version: 20_250_312_161_640) do # rubocop:disable Metrics/BlockLength
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_catalog.plpgsql'

  create_table 'departments', force: :cascade do |t|
    t.string 'name'
    t.bigint 'organization_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['organization_id'], name: 'index_departments_on_organization_id'
  end

  create_table 'organizations', force: :cascade do |t|
    t.string 'name'
    t.string 'slug'
    t.string 'admin_email'
    t.boolean 'is_deleted'
    t.integer 'deleted_by'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_roles_on_name', unique: true
  end

  create_table 'user_roles', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'role_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['role_id'], name: 'index_user_roles_on_role_id'
    t.index ['user_id'], name: 'index_user_roles_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'dob'
    t.datetime 'doj'
    t.string 'employee_id'
    t.string 'gender'
    t.string 'email', null: false
    t.string 'password_digest'
    t.string 'role', null: false
    t.datetime 'deleted_at'
    t.integer 'deleted_by'
    t.bigint 'organization_id', null: false
    t.bigint 'manager_id'
    t.bigint 'hr_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['hr_id'], name: 'index_users_on_hr_id'
    t.index ['manager_id'], name: 'index_users_on_manager_id'
    t.index ['organization_id'], name: 'index_users_on_organization_id'
  end

  add_foreign_key 'departments', 'organizations'
  add_foreign_key 'user_roles', 'roles'
  add_foreign_key 'user_roles', 'users'
  add_foreign_key 'users', 'organizations'
  add_foreign_key 'users', 'users', column: 'hr_id'
  add_foreign_key 'users', 'users', column: 'manager_id'
end
