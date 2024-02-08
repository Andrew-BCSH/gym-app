# app/controllers/qr_code_info_controller.rb
class QrCodeInfoController < ApplicationController
  def show
    # Retrieve the information stored in the QR code
    # You can access the information based on the parameters passed in the request
    @user_id = params[:user_id]
    @mejiro_coin_balance = params[:mejiro_coin_balance]
    # Add more information as needed

    # Render the view template
    # You can pass the retrieved information to the view template
  end
end
