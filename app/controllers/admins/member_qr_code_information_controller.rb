# app/controllers/admins/member_qr_code_information_controller.rb
class Admins::MemberQrCodeInformationController < ApplicationController

  class Admins::MemberQrCodeInformationController < ApplicationController
    def show
      # Retrieve the user from the database using the user_id obtained from the QR code data
      user_id = params[:user_id]
      @user = User.find_by(id: user_id)

      if @user
        # Calculate membership_days_remaining
        @membership_days_remaining = @user.membership_days_remaining

        # Retrieve mejiro_coin_balance (Replace this with your actual implementation)
        @mejiro_coin_balance = 0

        # Render the view
        render 'show'
      else
        # Handle the case where the user is not found
        flash[:error] = "User not found."
        redirect_to root_path
      end
    end
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
