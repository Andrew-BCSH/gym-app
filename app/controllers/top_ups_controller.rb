class TopUpsController < ApplicationController
  def index
    # Fetch top-up options from your database or any other source
    #@top_ups = TopUp.all  # Or you can customize this query based on your needs
    @plans = [100_000_00, 200_000_00, 500_000_00, 1_000_000_00]
  end

  def top_up
    # Calculate the top-up amount based on user selection (e.g., params[:amount])
    amount_in_idr = params[:amount].to_i * 100  # Convert to cents

    # Create a top-up record with the pending state


    # Update the top-up record with the Stripe session ID
    top_up.update(checkout_session_id: stripe_session.id)

    # Redirect the user to the Stripe payment page
    redirect_to stripe_session.url, allow_other_host: true, status: 302
  end

  def checkout
    # Retrieve the top-up record based on the checkout session ID
    top_up = TopUp.create!(
      state: 'pending',
      amount_cents: params[:amount].to_i,
      amount_currency: 'IDR', # Assuming your currency is IDR
      checkout_session_id: '', # Leave this empty for now
      user: current_user
    )

    # Create a Stripe session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'idr',
            unit_amount: params[:amount].to_i,
            product_data: {
              name: 'Mejiro Coin Top-Up',
              description: 'Top-Up your Mejiro Coin balance'
            },
          },
          quantity: 1,
        }
      ],
      mode: 'payment',
      success_url: top_up_success_url(top_up),
      cancel_url: top_up_failure_url(top_up)
    )

    top_up.update(checkout_session_id: session.id)
    redirect_to session.url, allow_other_host: true, status: 302
  end

  def show_success
    @top_up = TopUp.find(params[:id])

    if @top_up.state != "completed"
      if current_user.save
        @top_up.update(state: 'completed')
        # Assuming 'amount_cents' contains the top-up amount in currency
        current_user.top_up_balance(@top_up.amount_cents / 100)
        flash[:notice] = 'Payment was successful, and your balance has been updated!'
      else
        flash[:alert] = 'Payment was successful, but there was an issue updating your balance.'
      end
    end
    render action: 'show'
  end

  def show_failure
    @top_up= TopUp.find(params[:id])
    # Payment failed, handle accordingly (e.g., mark as failed, show an error message)
    @top_up.update(state: 'failed')
    flash[:alert] = 'Payment failed. Please try again.'
    render action: "show"
  end
end
