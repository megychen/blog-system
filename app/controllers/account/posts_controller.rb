class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account_post, :only => [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.blog = current_user.blog

    if @post.save!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to dashboard_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_id)
  end

  def find_account_post
    @post = Post.find(params[:id])
  end
end
