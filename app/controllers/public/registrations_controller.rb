class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication, only: [:new, :create]

  def create
    if User.where(email: sign_up_params[:email]).where(is_active: false)
      flash[:alert] = 'このメールアドレスは既に退会済みです。再登録はできません。'
      redirect_to new_user_registration_path and return
    end
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture, :city, :town])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :prefecture, :city, :town, :profile_image])
  end

  def after_sign_up_path_for(resource)
    mypage_users_path
  end

  def after_update_path_for(resource)
    mypage_users_path
  end

end
