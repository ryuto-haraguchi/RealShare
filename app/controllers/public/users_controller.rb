class Public::UsersController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]
  before_action :permission_confirmation, only: [:update, :destroy]

  def index
    # N+1問題の解決: profile_image_attachmentを事前ロード
    @users = User.includes(profile_image_attachment: :blob)
                  .where.not(email: "guest@example.com")
                  .where(is_active: true)
                  .page(params[:page])
                  .per(5)
  end

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)
  end

  def update
    if current_user.update(user_params)
      redirect_to mypage_users_path
    else
      render :mypage
    end
  end

  def show
    @user = User.active_users.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "ユーザーが見つかりませんでした"
      redirect_to users_path
    else 
      @posts = @user.posts.page(params[:page]).per(5)
    end
  end

  def destroy
    @user = current_user
    @user.update(is_active: false)
    sign_out @user
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:is_public, :is_active)
  end

  def permission_confirmation
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "他のユーザーの情報は編集できません"
      redirect_to mypage_users_path
    end
  end

end
