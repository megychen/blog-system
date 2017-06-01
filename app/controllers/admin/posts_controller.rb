class Admin::PostsController < AdminController
  before_action :find_admin_post, :except => [:index]
  layout "admin"

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_id)
  end

  def find_admin_post
    @post = Post.find(params[:id])
  end
end
