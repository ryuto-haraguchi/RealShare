class Admin::HomesController < Admin::ApplicationController

  def top
    @previous_day_registration_users = User.where(created_at: Time.zone.yesterday.all_day).excluding_guest
    @previous_day_registration_unsubscribe_users = User.where(updated_at: Time.zone.yesterday.all_day, is_active: false).excluding_guest
    @notices = Notice.where(status: 0)
  end

end
