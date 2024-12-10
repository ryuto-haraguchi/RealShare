class Public::PostsController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]

  def index
    @posts = Post.all.page(params[:page]).per(5).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
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
  
end
