class CreatePosts < ActiveRecord::Migration[6.1]

  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category, null: false, default: 0
      t.integer :price
      t.datetime :timing
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :town, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end
  end
  
end
