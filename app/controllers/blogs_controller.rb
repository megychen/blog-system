class BlogsController < ApplicationController
  def index
    @blog = Blog.find_by_title(params[:blog])
    if @blog.blank?
      redirect_to root_path, notice: "没有找到相关的博客"
    end
  end
end
