# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change # rubocop:disable Metrics/AbcSize
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :dob
      t.datetime :doj # date of joining
      t.string :employee_id
      t.string :gender
      t.string :email, null: false
      t.string :password_digest
      t.string :role, null: false # We will still allow single role for simplicity in this approach
      t.datetime :deleted_at # For soft delete
      t.integer :deleted_by # For tracking who deleted the user
      t.references :organization, null: false, foreign_key: true
      t.references :manager, foreign_key: { to_table: :users }
      t.references :hr, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
