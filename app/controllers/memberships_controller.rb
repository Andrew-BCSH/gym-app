class MembershipsController < ApplicationController
  def index
    @memberships = Membership.includes(:user)
  end

  def show
    @membership = Membership.find(params[:id])
  end

end
