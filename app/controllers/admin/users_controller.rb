class Admin::UsersController < ApplicationController

  def index
    @users = User.excluding_guest
    if params[:filter].present?
      @users = @users.get_by_filter(params[:filter])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to notices_path
  end

end
