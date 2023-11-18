class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password, null: false
      t.string :user_token, null: false
      t.timestamps null: false
      t.string :salt
    end
  end
end
