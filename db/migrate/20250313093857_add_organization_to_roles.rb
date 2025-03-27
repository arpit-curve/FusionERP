class AddOrganizationToRoles < ActiveRecord::Migration[8.0]
  def change
    add_reference :roles, :organization, foreign_key: true
  end
end
