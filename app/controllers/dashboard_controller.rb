class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_search_key, only: [:search]
  layout "account"

  def index
    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @posts = current_user.posts.where(category_id: @category_id).recent
      #binding.pry
    else
      @posts = current_user.posts.recent
    end
  end

  def search
    if @query_string.present?
      @posts = search_params
    end
  end

  private

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    current_user.posts.ransack({:title_or_description_cont => @query_string}).result(distinct: true)
  end
end
