class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout "admin"

  def index
    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @posts = current_user.posts.where(category_id: @category_id).recent
      #binding.pry
    else
      @posts = current_user.posts.recent
    end
  end
end
