class Account::BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account_blog
  layout "admin"

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title)
  end

  def find_account_blog
    @blog = Blog.find(params[:id])
    unless @blog.user == current_user
      flash[:warning] = "You have no permission"
      redirect_to dashboard_path
    end
  end
end
