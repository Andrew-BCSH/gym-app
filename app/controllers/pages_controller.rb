# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
    # Your home action logic
  end

  def membership_payment
    @options = Option.all
  end

  def book_a_private_class
    # Your book_a_private_class action logic
  end

  def mejiro_coin
    # Your mejiro_coin action logic
  end

  def payment_scanner
    # Your payment_scanner action logic
  end

  def weekly_class_schedule
    # Your weekly_class_schedule action logic
  end

  def events
    # Your events action logic
  end

  def top_up
    # Your top-up logic here
    # For example, you can update the user's balance here
  end

  # In your PagesController's membership_checkout action
  def membership_checkout
  @option = Option.find_by(params[:option_sku])
  # ...
  end



  def qr_code_scanner
    respond_to do |format|
      format.html
      format.json {
        # Handle the QR code scanning functionality here, e.g., using Quagga or ZXing
        scanned_data = scan_qr_code(params[:qr_code_image])

        render json: { scanned_data: scanned_data }
      }
    end
  end



  # Define any other actions and private methods if needed
end
