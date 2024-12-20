class Post < ApplicationRecord

  enum category: { "buy": 0, "sale": 1, "rental": 2, "local_information": 3 }

  belongs_to :user
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
  validate :validate_geocode

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

  private

  def validate_geocode
    result = Geocoder.search(full_address).first
  
    if result.nil?
      errors.add(:full_address, "が無効です。入力内容を確認してください。")
      return
    end
  
    # 都道府県、市区町村、町名を検証
    prefecture_valid = result.data['address_components'].any? do |component|
      component['types'].include?('administrative_area_level_1') && component['long_name'] == prefecture
    end
  
    city_valid = result.data['address_components'].any? do |component|
      component['types'].include?('locality') && component['long_name'] == city
    end
  
    town_valid = result.data['address_components'].any? do |component|
      component['types'].include?('sublocality') && component['long_name'] == town
    end
  
    unless prefecture_valid && city_valid && town_valid
      errors.add(:full_address, "が無効です。正しい住所を入力してください。")
    end
  end

end
