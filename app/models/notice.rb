class Notice < ApplicationRecord

  enum status: { "unconfirmed": 0, "confirmed": 1 }

  belongs_to :user
  belongs_to :noticeable, polymorphic: true

  validates :reason, presence: true

  def status_i18n
    I18n.t("enums.notice.status.#{status}")
  end
  
end
