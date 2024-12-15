class Public::CommentsController < Public::ApplicationController
  before_action :permission_confirmation, only: [:destroy]

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

  def permission_confirmation
    user = Comment.find(params[:id]).user
    unless user.id == current_user.id
      flash[:alert] = "他のユーザーのコメントは削除できません"
      redirect_to mypage_users_path
    end
  end

end
