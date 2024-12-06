class Public::PostsController < ApplicationController

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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_users_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :prefecture, :city, :town, :latitude, :longitude).merge(user_id: current_user.id)
  end
  
end
