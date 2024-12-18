class Public::UsersController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]

  def index
    @users = User.excluding_guest
  end

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def update
    if current_user.update(user_params)
      redirect_to mypage_users_path
    else
      render :mypage
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(3)
  end

  def user_params
    params.require(:user).permit(:is_public, :is_active)
  end

end
