# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  # Your custom actions and methods can be defined here
  # For example, you can add custom logic after a user signs in.

  # This will execute after a successful sign-in
  def after_sign_in_path_for(resource)
    # You can customize where the user is redirected after signing in
    # For example, redirect to the user's dashboard:
    user_dashboard_path
  end
end
