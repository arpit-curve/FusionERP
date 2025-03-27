class MakeDesignationIdNotNullInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :designation_id, false
  end
end
