class Admins::SessionsController < Devise::SessionsController
  # This will execute after a successful sign-in

  def create
    super do |resource|
    params.require(:admin).permit(:admin_name, :password, :remember_me)
  end
end

  def after_sign_in_path_for(resource)
    # Redirect to the home page after sign-in
    admin_dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
