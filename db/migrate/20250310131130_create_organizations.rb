# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :slug
      t.string :admin_email
      t.boolean :is_deleted
      t.integer :deleted_by

      t.timestamps
    end
  end
end
