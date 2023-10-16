Rails.application.routes.draw do
  get 'membership_payments/index'

  devise_for :users
  root to: 'pages#home' # Define your root route
  resources :orders, only: [:show, :create]

  # Define routes for other actions
  get '/membership_payment', to: 'pages#membership_payment'
  get '/book_a_private_class', to: 'pages#book_a_private_class'
  get '/mejiro_coin', to: 'pages#mejiro_coin'
  get '/payment_scanner', to: 'pages#payment_scanner'
  get '/weekly_class_schedule', to: 'pages#weekly_class_schedule'
  get '/events', to: 'pages#events'
  get 'top_up', to: 'pages#top_up'
  get '/qr_code_scanner', to: 'pages#qr_code_scanner'
  get '/membership_checkout', to: 'pages#membership_checkout'


  #back arrow
  get 'go_back', to: 'pages#go_back'


  # Custom sign-out route
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"

  end

# config/routes.rb
  namespace :pages do
  get 'membership_payments', to: 'membership_payments#index'
  end


  # Additional routes for other actions if needed

end
