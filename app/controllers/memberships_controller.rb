class MembershipsController < ApplicationController
  def create
    option = Option.find(params[:option_sku])
    membership  = Membership.create!(option: option, option_sku: option.sku, amount: option.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: option.sku,
        images: [option.photo_url],
        amount: option.price_cents,
        currency: 'idr',
        quantity: 1
      }],
      success_url: membership_url(membership),
      cancel_url: membership_url(membership)

    )

    membership.update(checkout_session_id: session.id)
    redirect_to new_membership_checkout_path(membership)

  end
end
