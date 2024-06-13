class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :photo, whatsapp_number_attributes: [:id, :number]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :photo, :password, :password_confirmation, :current_password, whatsapp_number_attributes: [:id, :number]])
  end

  def update_resource(resource, params)
    whatsapp_number_params = params.delete(:whatsapp_number_attributes)

    if whatsapp_number_params
      if resource.whatsapp_number.nil?
        resource.build_whatsapp_number(whatsapp_number_params)
      else
        resource.whatsapp_number.update(whatsapp_number_params)
      end
    end

    super(resource, params)
  end
end
