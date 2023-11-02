# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  # Your custom actions and methods can be defined here

  # This will execute after a successful sign-in
  def after_sign_in_path_for(resource)
    # Redirect to the home page
    '/home'
  end
end
