class RemovePriceFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :price
  end
end
