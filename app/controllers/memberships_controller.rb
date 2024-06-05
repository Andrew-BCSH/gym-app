class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def assign
    user = User.find(params[:user_id])
    membership = Membership.find(params[:membership_id])

    if user && membership
      user.memberships << membership
      membership.update(user: user)
      flash[:success] = "Membership assigned successfully."
    else
      flash[:error] = "User or Membership not found."
    end

    redirect_to some_path # Replace with the path you want to redirect to
  end
end
