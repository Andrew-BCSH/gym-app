class OrdersController < ApplicationController
  def create
    membership = Membership.find(params[:membership_id])
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
          # price: membership.price,  # Replace with your actual price ID
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
      mode:'payment',
      success_url: order_url(order),
      cancel_url: order_url(order)
    )


    order.update(checkout_session_id: session.id)
    redirect_to session.url, allow_other_host: true
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
