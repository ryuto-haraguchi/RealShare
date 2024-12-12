class Group < ApplicationRecord

  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :posts, through: :users

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }

  def user_joined?(user)
    users.include?(user)
  end
  
end
