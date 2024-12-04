class Public::UsersController < ApplicationController

  def index
    @users = User.excluding_guest
  end

  def mypage
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(3)
  end

  private

  def user_params
    params.require(:user).permit(:name, :prefecture, :city, :town, :profile_image)
  end

end
