class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :require_admin!

  protected

  def require_admin!
    if current_user.role != "admin"
      flash[:alert] = "You have no permission"
      redirect_to root_path
    end
  end
end
