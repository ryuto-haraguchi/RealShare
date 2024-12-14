class Admin::NoticesController < Admin::ApplicationController

  def index
    if params[:notices_ids].present?
      @notices = Notice.where(id: params[:notices_ids]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @notices = Notice.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @notice = Notice.find(params[:id])
    if @notice.noticeable_type == "Post"
      @noticeable = Post.find(@notice.noticeable_id)
    elsif @notice.noticeable_type == "User"
      @noticeable = User.find(@notice.noticeable_id)
    elsif @notice.noticeable_type == "Comment"
      @noticeable = Comment.find(@notice.noticeable_id)
    end
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.status == "unconfirmed"
      if @notice.update(status: 1)
        redirect_to admin_notice_path(@notice)
      else
        render :show
      end
    elsif @notice.status == "confirmed"
      if @notice.update(status: 0)
        redirect_to admin_notice_path(@notice)
      else
        render :show
      end
    end
  end

end
