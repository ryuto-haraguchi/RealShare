class Public::CommentsController < Public::ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      render 'public/posts/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

end
