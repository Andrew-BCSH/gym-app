class Admins::DashboardController < AdminController
  before_action :authenticate_admin!

  def index
    render 'admins/dashboard/index'
  end
end
