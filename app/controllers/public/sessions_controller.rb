class Public::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, only: [:new, :create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
  end

  protected

  def after_sign_in_path_for(resource)
    posts_path
  end

end
