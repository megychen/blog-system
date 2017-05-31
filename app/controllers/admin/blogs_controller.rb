class Admin::BlogsController < AdminController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :find_admin_blog, :except => [:index]
  layout "admin"

  def index
    @blogs = Blog.includes(:posts)
  end

  def show
    @posts = @blog.posts
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to admin_blogs_path
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:alert] = "Blog has been deleted"
    redirect_to admin_blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :description)
  end

  def find_admin_blog
    @blog = Blog.find(params[:id])
  end
end
