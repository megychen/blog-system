class BlogsController < ApplicationController
  before_action :find_blog, :except => [:index]
  layout "blog", :except => [:index]
  def index
    @blogs = Blog.includes(:posts)
  end

  def show
    @posts = @blog.posts.where(:status => "public").recent.paginate(:page => params[:page], :per_page => 5)
  end

  def archives
    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @posts = @blog.posts.where(:status => "public", category_id: @category_id).recent
    else
      @posts = @blog.posts.where(:status => "public").recent
    end
  end

  def about
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end
end
