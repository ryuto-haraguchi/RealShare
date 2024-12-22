class GroupUser < ApplicationRecord

  belongs_to :user
  belongs_to :group, counter_cache: :users_count

end
