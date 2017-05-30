class PostsController < ApplicationController
  layout "blog"

  def show
    @post = Post.find(params[:id])
    @blog = @post.blog
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user
  end
end
