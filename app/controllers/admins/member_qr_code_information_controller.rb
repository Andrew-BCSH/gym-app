# app/controllers/admins/member_qr_code_information_controller.rb
class Admins::MemberQrCodeInformationController < ApplicationController

  def show
    # Decode the QR code data
    # @decoded_data = decode_qr_code(params[:qr_code_data])

    # Generate the URL based on the decoded data
    # You need to replace the placeholders with the actual user_id and mejiro_coin_balance
    user_id = request.query_parameters[:user_id]
    user = User.find(user_id.to_i)
    credit = user.credit

    # mejiro_coin_balance = 0 # @decoded_data[:mejiro_coin_balance]
    # qr_code_info_url = admins_qr_code_information_url(user_id: user_id, mejiro_coin_balance: mejiro_coin_balance)

    # Redirect the admin to the generated URL
    # redirect_to qr_code_info_url
    # render json: { user_id: user_id }
    @decoded_data = @decoded_data = { user_id: user_id, user: user, credit: user_credit }
  end

  private

  def decode_qr_code(qr_code_data)
    # Decode the QR code data using rqrcode gem
    decoded_data = RQRCode::QRCode.new(qr_code_data).as_text

    # Return the decoded data
    decoded_data
  rescue RQRCode::DecodeError => e
    # Handle decoding errors
    Rails.logger.error "Error decoding QR code: #{e.message}"
    nil
  end
end
