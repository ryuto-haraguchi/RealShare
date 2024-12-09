class Public::GroupUsersController < Public::ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

  def join
    @group = Group.find(params[:group_id])
    if @group.group_users.create(user: current_user)
      flash[:notice] = "グループに参加しました"
      redirect_to group_path(@group)
    else
      redirect_to group_path(@group), alert: "参加に失敗しました"
    end
  end

  def leave
    @group = Group.find(params[:group_id])
    group_user = @group.group_users.find_by(user_id: current_user.id)
    group_user.destroy
    flash[:notice] = "グループを退会しました"
    redirect_to groups_path
  end

end
