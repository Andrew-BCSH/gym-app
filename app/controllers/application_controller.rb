class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :photo, :whatsapp_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :photo, :password, :password_confirmation, :current_password, :whatsapp_number])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
