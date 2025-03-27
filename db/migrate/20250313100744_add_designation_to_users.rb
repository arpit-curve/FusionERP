class AddDesignationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :designation, foreign_key: true
  end
end
