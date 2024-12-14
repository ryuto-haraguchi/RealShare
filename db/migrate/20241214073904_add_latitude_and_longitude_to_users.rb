class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :latitude, :float, null: false, default: 0.0
    add_column :users, :longitude, :float, null: false, default: 0.0
  end
end
