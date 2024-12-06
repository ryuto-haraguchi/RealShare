class Admin::CommentsController < ApplicationController
  def show
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_post_path(@comment.post)
  end
  
end
