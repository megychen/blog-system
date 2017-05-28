class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.recent
  end
end
