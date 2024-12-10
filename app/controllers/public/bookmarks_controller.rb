class Public::BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.new(post_id: @post.id)
    @bookmark.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.find_by(post: @post)
    @bookmark.destroy
    respond_to do |format|
      format.js
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.bookmark_posts.page(params[:page]).per(3)
  end

end
