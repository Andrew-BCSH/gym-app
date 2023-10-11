Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home' # Define your root route

  # Define routes for other actions
  get '/monthly_membership_payment', to: 'pages#monthly_membership_payment'
  get '/book_a_private_class', to: 'pages#book_a_private_class'
  get '/mejiro_coin', to: 'pages#mejiro_coin'
  get '/payment_scanner', to: 'pages#payment_scanner'
  get '/weekly_class_schedule', to: 'pages#weekly_class_schedule'
  get '/events', to: 'pages#events'

  # Custom sign-out route
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
  end

  # Additional routes for other actions if needed
end
