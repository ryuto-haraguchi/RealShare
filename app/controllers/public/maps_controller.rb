class Public::MapsController < Public::ApplicationController

  def index
    respond_to do |format|
      format.html do
        @posts = Post.all
      end
      format.json do
        @posts = Post.all
      end
    end
  end

end
