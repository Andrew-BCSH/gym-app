module Users
  class QrCodeInfoController < ApplicationController
    before_action :validate_and_set_user, only: :show

    def show
      if @user
        @mejiro_coin_balance = params[:mejiro_coin_balance]

        # Ensure @mejiro_coin_balance is a valid number
        unless valid_balance?(@mejiro_coin_balance)
          render plain: "Invalid Mejiro coin balance", status: :unprocessable_entity and return
        end

        # Retrieve the user's membership details
        @membership = @user.memberships.last

        # Generate URLs based on the retrieved information
        @qr_code_info_url = qr_code_info_url(user_id: @user.id, mejiro_coin_balance: @mejiro_coin_balance)

        # Render the view template with the retrieved information
      else
        render plain: "User not found", status: :not_found
      end
    end

    private

    def validate_and_set_user
      @user = User.find_by(id: params[:user_id])
    end

    def valid_balance?(balance)
      balance.present? && balance.to_s.match?(/\A\d+(\.\d{1,2})?\z/)
    end

    def qr_code_info_params
      params.permit(:user_id, :mejiro_coin_balance)
    end
  end
