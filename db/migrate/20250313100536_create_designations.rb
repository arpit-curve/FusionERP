class CreateDesignations < ActiveRecord::Migration[8.0]
  def change
    create_table :designations do |t|
      t.string :name, null: false
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
