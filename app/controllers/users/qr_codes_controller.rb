# app/controllers/users/qr_codes_controller.rb
class Users::QrCodesController < ApplicationController
  before_action :authenticate_user!

  def show
    # Logic to retrieve QR code data for the current user
    @qr_code_data = current_user.qr_code_data if current_user
  end
end
