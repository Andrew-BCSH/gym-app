# app/controllers/admins/member_qr_code_information_controller.rb
class Admins::MemberQrCodeInformationController < ApplicationController
  def show
    # Decode the QR code data
    @decoded_data = decode_qr_code(params[:qr_code_data])
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
