class Admins::DashboardController < AdminController
  before_action :authenticate_admin!

  def index
    # Add logic or data retrieval as needed
    render 'admins/dashboard/index'
  end
end
