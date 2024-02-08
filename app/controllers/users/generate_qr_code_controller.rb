# app/controllers/users/generate_qr_code_controller.rb

class Users::GenerateQrCodeController < ApplicationController
  def generate_qr_code
    # Generate the QR code image using the rqrcode gem
    qrcode = RQRCode::QRCode.new(qr_code_data, size: 10)
    qr_code_image = qrcode.as_png

    # Respond with the generated QR code image
    send_data qr_code_image.to_s, type: 'image/png', disposition: 'inline'
  rescue => e
    # Log the error for debugging
    Rails.logger.error "Error generating QR code: #{e.message}"

    # Handle any errors that occur during the process
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def qr_code_data
    # Define the data you want to include in the QR code for the user
    qr_data = {
      user_id: current_user.id,
      mejiro_coin_balance: current_user.credit&.balance || 0,
      # Add more data as needed
    }

    # Convert the data to a JSON string
    qr_data.to_json
  end
end
