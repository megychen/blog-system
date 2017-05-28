class Account::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account_blog
  before_action :find_account_blog_category, :except => [:index, :create]

  def index
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.blog = @blog

    if @category.save
      redirect_to account_blog_categories_path
    else
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to account_blog_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to account_blog_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_account_blog
    @blog = current_user.blog
  end

  def find_account_blog_category
    @category = Category.find(params[:id])
  end
end
