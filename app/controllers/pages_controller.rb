# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
    # Your home action logic
  end

  def book_a_private_class
    # Your book_a_private_class action logic
  end

  def mejiro_coin
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

  def membership_checkout
    membership = Membership.find(params[:id])
    order = Order.create!(
      membership: membership,
      membership_sku: membership.sku,
      amount_cents: membership.price,
      state: 'pending',
      user: current_user
    )

    Stripe.api_key = "sk_test_51O1kcoBYTyCXur6X4GdrGK54WiyUxDj0VsRJvETiUGnL8hWjpQqZwh7HDnogr20W1fuwEIkQ01AjGXTQKIpk7PAg00qDOeVKPC"

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          quantity: 1,
          price_data: {
            currency: 'idr',
            unit_amount: membership.price.to_i,
            product_data: {
              name: membership.name,
              description: 'Comfortable cotton t-shirt',
              images: ['https://example.com/t-shirt.png'],
            },
          },
        }
      ],
      mode: 'payment',
      success_url: order_url(order),
      cancel_url: order_url(order)
    )
    order.update(checkout_session_id: session.id)
    redirect_to session.url, allow_other_host: true, status: 302
  end

  def show_product
    @product = Product.find(params[:id])
  end

  def purchase_product
    @product = Product.find(params[:id])
    if @product.in_stock
      @user_credit = current_user.credit if user_signed_in?
      if @user_credit.balance >= @product.price
        @user_credit.balance = @user_credit.balance - @product.price
        @receipt = Receipt.create!(
          product_id:@product.id,
          product_name:@product.name,
          product_price:@product.price,
          product_category:@product.category,
          user_id:current_user.id,
          user_post_balance:@user_credit.balance,
          timestamp:DateTime.now
        )
      else
        flash[:notice] = "Not enough Mejiro Coin"
      end
    else
      flash[:notice] = "Product not in stock"
    end
  end


  # Define any other actions and private methods if needed
end
