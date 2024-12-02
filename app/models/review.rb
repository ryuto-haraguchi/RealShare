class Review < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  #　nullではないこと、数値であること、1以上5以下であることを検証
  
end
