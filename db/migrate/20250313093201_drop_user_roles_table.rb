# frozen_string_literal: true

class DropUserRolesTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :user_roles
  end
end
