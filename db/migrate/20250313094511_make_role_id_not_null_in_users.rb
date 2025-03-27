class MakeRoleIdNotNullInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :role_id, false
    change_column_null :roles, :organization_id, false
  end
end
