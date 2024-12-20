class RemovePriceTimingFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :timing
  end
end
