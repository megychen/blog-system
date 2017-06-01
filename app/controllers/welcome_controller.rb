class WelcomeController < ApplicationController
  def index
    @posts = Post.all.sort_by{|post| -post.impressionist_count(:filter=>:session_hash)}
    @posts = @posts.first(10)
  end
end
