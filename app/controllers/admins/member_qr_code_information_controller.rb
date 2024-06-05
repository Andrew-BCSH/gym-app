class Admins::MemberQrCodeInformationController < ApplicationController
  def show
    user_id = request.query_parameters[:user_id]
    user = User.includes(:memberships).find(user_id.to_i)
    credit = user.credit

    # Collect membership names
    membership_names = user.memberships.map(&:name).join(", ")

    @decoded_data = { user_id: user_id, user: user, credit: credit, membership_names: membership_names }
  end

  private

  def decode_qr_code(qr_code_data)
    decoded_data = RQRCode::QRCode.new(qr_code_data).as_text
    decoded_data
  rescue RQRCode::DecodeError => e
    Rails.logger.error "Error decoding QR code: #{e.message}"
    nil
  end
end
