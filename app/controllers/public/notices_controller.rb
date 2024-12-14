class Public::NoticesController < ApplicationController

  def new
    @notice = Notice.new
    @noticeable = params[:noticeable_type].constantize.find_by(id: params[:noticeable_id])
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.user_id = current_user.id
    if @notice.save
      flash[:notice] = "通報しました"
      redirect_to mypage_users_path
    else
      @noticeable = params[:notice][:noticeable_type].constantize.find_by(id: params[:notice][:noticeable_id])
      flash.now[:alert] = "通報内容を入力してください"
      render :new
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:user_id, :noticeable_id, :noticeable_type, :reason)
  end
end

