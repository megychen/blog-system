class BlogsController < ApplicationController
  def index
    @posts = current_user.blog.posts
  end
end
