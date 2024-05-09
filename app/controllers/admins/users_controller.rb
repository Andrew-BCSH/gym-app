class Admins::UsersController < ApplicationController
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_back fallback_location: admins_memberships_path, notice: "User deleted successfully."
  end
end
