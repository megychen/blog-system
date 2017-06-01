class WelcomeController < ApplicationController
  def index
    @posts = Post.where(:status => "public").sort_by{|post| -post.impressionist_count(:filter=>:session_hash)}
    @posts = @posts.first(10)
  end

  def more_posts
    @posts = Post.where(:status => "public").recent.all
  end
end
