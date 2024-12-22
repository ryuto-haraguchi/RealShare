class Public::SearchesController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]
  
  def index
    if params[:keyword].present?
      @posts = Post.where('title LIKE :keyword OR content LIKE :keyword', keyword: "%#{params[:keyword]}%").includes(user: {profile_image_attachment: :blob}).page(params[:page]).per(5).order(created_at: :desc)
      if @posts.blank?
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_back fallback_location: posts_path
      end
    elsif params[:user_name].present?
      @users = User.where('name LIKE :user_name', user_name: "%#{params[:user_name]}%").includes(profile_image_attachment: :blob).page(params[:page]).per(5).order(created_at: :desc)
      if @users.blank?
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_back fallback_location: users_path
      end
    elsif params[:group_name].present?
      @groups = Group.where('name LIKE :group_name', group_name: "%#{params[:group_name]}%").page(params[:page]).per(5).order(created_at: :desc)
      if @groups.blank?
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_back fallback_location: groups_path
      end
    else
      flash[:alert] = "検索ワードを入力してください"
      redirect_back fallback_location: posts_path
    end
  end

end
