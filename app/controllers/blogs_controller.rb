class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.where(:status => "public").recent.paginate(:page => params[:page], :per_page => 5)
  end

  def archives
    @blog = Blog.find(params[:id])
    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @posts = @blog.posts.where(:status => "public", category_id: @category_id).recent
    else
      @posts = @blog.posts.where(:status => "public").recent
    end
  end
end
