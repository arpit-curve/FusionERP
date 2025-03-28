class CreateBlacklistedTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :blacklisted_tokens do |t|
      t.string :token

      t.timestamps
    end
    add_index :blacklisted_tokens, :token
  end
end
