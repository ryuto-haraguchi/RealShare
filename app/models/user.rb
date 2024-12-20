class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post dependent: :destroy
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id', dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :received_notices, as: :noticeable, class_name: 'Notice', dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 50 }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :town, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  geocoded_by :full_address
  before_validation :geocode

  before_update :user_leave
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.prefecture = "東京都"
      user.city = "港区"
      user.town = "六本木"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  scope :excluding_guest, -> { where.not(email: GUEST_USER_EMAIL) }

  def full_address
    "#{prefecture}#{city}#{town}"
  end

  scope :active_users, -> { where(is_active: true) }

  private

  def user_leave
    if is_active_changed? && !is_active
      posts.destroy_all
      comments.destroy_all
      groups.destroy_all
      bookmarks.destroy_all
      sign_out current_user
    end
  end

end
