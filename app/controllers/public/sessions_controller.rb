class Public::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, only: [:new, :create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.is_active == false
      flash[:alert] = "退会済みのユーザーのため、再登録が必要です。"
      redirect_to new_user_registration_path
    super
    end
  end

  protected

  def after_sign_in_path_for(resource)
    mypage_users_path
  end

end
