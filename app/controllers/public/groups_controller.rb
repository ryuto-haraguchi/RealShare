class Public::GroupsController < Public::ApplicationController
  skip_before_action :restrict_guest_user, only: [:index]
  before_action :permission_confirmation, only: [:update, :edit, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order(created_at: :desc).page(params[:page]).per(5)
    @bookmark = current_user.bookmarks.where(post_id: @posts.pluck(:id))
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.group_users.create(user: current_user)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def user_groups
    unless params[:user_id].nil?
      @groups = User.find(params[:id]).groups
    else
      @groups = current_user.groups
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def permission_confirmation
    user = Group.find(params[:id]).owner
    unless user.id == current_user.id
      flash[:alert] = "グループオーナー以外は編集できません"
      redirect_to mypage_users_path
    end
  end

end
