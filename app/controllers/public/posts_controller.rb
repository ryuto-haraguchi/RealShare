class Public::PostsController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]
  before_action :permission_confirmation, only: [:update, :edit, :destroy]

  def index
    @posts = Post.all
    #フィルター機能
    @posts = @posts.where(category: params[:category]) if params[:category].present?
    @posts = @posts.where(prefecture: params[:prefecture]) if params[:prefecture].present?
    # ソート機能（デフォルトを設定し、動的に変更）
    sort_order = case params[:sort]
    when "new"
      { created_at: :desc }
    when "old"
      { created_at: :asc }
    else
      { created_at: :desc } # デフォルトは新しい順
    end
    @posts = @posts.order(sort_order)
    #ページネーション付与
    @posts = @posts.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @bookmark = @post.bookmarks.find_by(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.json 
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_users_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :price, :timing, :prefecture, :city, :town, :latitude, :longitude).merge(user_id: current_user.id)
  end

  def permission_confirmation
    user = Post.find(params[:id]).user
    unless user.id == current_user.id
      flash[:alert] = "他のユーザーの情報は編集できません"
      redirect_to mypage_users_path
    end
  end
  
end
