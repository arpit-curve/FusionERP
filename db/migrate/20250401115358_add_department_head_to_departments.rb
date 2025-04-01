class AddDepartmentHeadToDepartments < ActiveRecord::Migration[8.0]
  def change
    add_column :departments, :department_head_id, :integer
    add_index :departments, :department_head_id
  end
end
