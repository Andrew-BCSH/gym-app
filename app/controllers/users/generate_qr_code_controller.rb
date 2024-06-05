# app/controllers/users/generate_qr_code_controller.rb

class Users::GenerateQrCodeController < ApplicationController
  before_action :authenticate_user!

  def generate_qr_code
    begin
      qrcode = RQRCode::QRCode.new(qr_code_data, size: 10)
      svg = qrcode.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )

      send_data svg.to_s, type: 'image/svg+xml', disposition: 'inline'
    rescue => e
      Rails.logger.error "Error generating QR code: #{e.message}"
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def qr_code_data
    membership = current_user.memberships.last
    qr_data = {
      user_id: current_user.id,
      mejiro_coin_balance: current_user.credit&.balance || 0,
      membership_name: membership&.name,
      membership_start_date: membership&.start_date,
      membership_end_date: membership&.end_date
    }

    qr_data.to_json
  end
end
