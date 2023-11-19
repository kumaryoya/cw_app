class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text :body, null: false
      t.datetime :reservation_time, null: false
      t.boolean :done, null: false
      t.timestamps
    end
  end
end
