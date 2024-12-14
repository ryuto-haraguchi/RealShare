class Admin::HomesController < Admin::ApplicationController

  def top
    @previous_day_registration_users = User.where(created_at: Time.zone.yesterday.all_day)
    @previous_day_registration_unsubscribe_users = User.where(updated_at: Time.zone.yesterday.all_day, is_active: false)
    @notices = Notice.where(status: 0)
  end

end
