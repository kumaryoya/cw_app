class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.references :room, null: false, foreign_key: true
      t.string :cw_user_name, null: false
      t.integer :cw_account_id, null: false
      t.timestamps
    end
  end
end
