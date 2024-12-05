class Public::SearchesController < ApplicationController

  def index
    if params[:keyword].present?
      @posts = Post.where('title LIKE :keyword OR content LIKE :keyword', keyword: "%#{params[:keyword]}%").page(params[:page]).per(5).order(created_at: :desc)
    else
      @posts = Post.all.page(params[:page]).per(5).order(created_at: :desc)
      flash[:alert] = "検索ワードを入力してください"
      redirect_back fallback_location: posts_path
    end
  end

end
