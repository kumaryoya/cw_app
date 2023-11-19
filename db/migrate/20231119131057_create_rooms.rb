class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cw_room_name, null: false
      t.integer :cw_room_id, null: false
      t.timestamps
    end
  end
end
