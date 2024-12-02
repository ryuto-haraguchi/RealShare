class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

end
