class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]  

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
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

end
