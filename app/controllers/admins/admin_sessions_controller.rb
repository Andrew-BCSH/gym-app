class Admins::SessionsController < Devise::SessionsController
  # This will execute after a successful sign-in
  def after_sign_in_path_for(resource)
    # Redirect to the home page after sign-in
    '/home'
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def create
    puts "Attempting to authenticate with parameters: #{sign_in_params.inspect}"
    self.resource = warden.authenticate!(auth_options)
    puts "Authenticated Resource: #{resource.inspect}"
    sign_in(resource_name, resource)
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def sign_in_params
  params.require(:admin).permit(:email, :password, :admin_name, :remember_me)
  end
end
