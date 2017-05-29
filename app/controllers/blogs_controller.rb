class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.where(:status => "public").paginate(:page => params[:page], :per_page => 5)
  end
end
