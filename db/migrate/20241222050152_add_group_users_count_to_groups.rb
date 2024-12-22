class AddGroupUsersCountToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :users_count, :integer, default: 0, null: false
  end
end
