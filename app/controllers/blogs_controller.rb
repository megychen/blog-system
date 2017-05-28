class BlogsController < ApplicationController
  def index
    @posts = current_user.blog.posts.where(:status => "public")
  end
end
