class Notice < ApplicationRecord

  enum status: { "unsupported": 0, "supported": 1 }

  belongs_to :user
  belongs_to :noticeable, polymorphic: true

  validates :reason, presence: true
  
end
