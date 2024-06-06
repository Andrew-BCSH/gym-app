class Admins::MemberQrCodeInformationController < ApplicationController
  def show
    user_id = request.query_parameters[:user_id]
    Rails.logger.debug "Received user_id: #{user_id}"

    if user_id.present?
      user = User.includes(:memberships).find_by(id: user_id.to_i)
      if user
        credit = user.credit
        membership_names = user.memberships.map(&:name).join(", ")
        last_membership = user.memberships.last
        last_membership_name = last_membership&.name
        last_membership_sku = last_membership&.sku

        @decoded_data = {
          user_id: user_id,
          user: user,
          credit: credit,
          membership_names: membership_names,
          last_membership_name: last_membership_name,
          last_membership_sku: last_membership_sku
        }
      else
        Rails.logger.debug "User not found"
        @decoded_data = { error: "User not found" }
      end
    else
      Rails.logger.debug "No user_id parameter provided"
      @decoded_data = { error: "No user_id parameter provided" }
    end
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
