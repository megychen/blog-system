class Admin::UsersController < AdminController
  before_action :find_user, :except => [:index]

  def index
    @users = User.all
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:alert] = "User deleted"
    redirect_to admin_users_path
  end

  def set_admin
    @user.admin!
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
