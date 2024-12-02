class DeviseCreateUsers < ActiveRecord::Migration[6.1]

  def change
    create_table :users do |t|
      t.string :name,               null: false, limit: 50
      t.boolean :is_public,         null: false, default: true
      t.boolean :is_active,         null: false, default: true
      t.string :prefecture,         null: false, default: ""
      t.string :city,               null: false, default: ""
      t.string :town,               null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
  
end
