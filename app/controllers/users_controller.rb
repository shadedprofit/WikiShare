class UsersController < ApplicationController

  def update
    @wikis = current_user.wikis

    if current_user.update_attributes(user_params)
      @wikis.update_all(:private => false) if current_user.role == nil || current_user.role == ''
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def show
    @user = current_user
    @wikis = @user.wikis
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:username, :role, :avatar, :private)
  end
end
