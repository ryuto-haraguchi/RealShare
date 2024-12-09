class Public::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_guest_user

  private

  def restrict_guest_user
    if current_user&.guest_user?
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行うことができません。'
    end
  end

end
