class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication, only: [:new, :create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture, :city, :town])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :prefecture, :city, :town])
  end

  def after_sign_up_path_for(resource)
    mypage_users_path
  end

  def after_update_path_for(resource)
    mypage_users_path
  end

end
