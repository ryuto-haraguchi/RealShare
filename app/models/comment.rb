class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_many :received_notices, as: :noticeable, class_name: 'Notice', dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }

end
