class Public::PostsController < ApplicationController

  def index
    @posts = Post.all.page(params[:page]).per(5).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end
  
end
