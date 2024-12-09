class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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

end
