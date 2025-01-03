class Post < ApplicationRecord

  enum category: { "buy": 0, "sale": 1, "rental": 2, "local_information": 3 }

  belongs_to :user, counter_cache: true
  # N+1問題の解決: counter_cacheを使って、userのpost_countをキャッシュ
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :received_notices, as: :noticeable, class_name: 'Notice', dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :town, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  geocoded_by :full_address
  before_validation :geocode, if: -> { prefecture_changed? || city_changed? || town_changed? }

  def category_i18n
    I18n.t("enums.post.category.#{category}")
  end

  def full_address
    [prefecture, city, town].compact.join("")
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end


end
