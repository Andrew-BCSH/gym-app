Rails.application.routes.draw do
  get 'memberships/index'

  devise_for :users
  root to: 'pages#home' # Define your root route
  resources :memberships, only: [:show, :index]
  resources :orders, only: [:show, :create]
  resources :payments, only: :new

  # Define routes for other actions
  get '/memberships', to: 'pages#memberships'
  get '/book_a_private_class', to: 'pages#book_a_private_class'
  get '/mejiro_coin', to: 'pages#mejiro_coin'
  get '/payment_scanner', to: 'pages#payment_scanner'
  get '/weekly_class_schedule', to: 'pages#weekly_class_schedule'
  get '/events', to: 'pages#events'
  get 'top_up', to: 'pages#top_up'
  get '/qr_code_scanner', to: 'pages#qr_code_scanner'
  get '/membership_details', to: 'pages#membership_details', as: 'membership_details'
  get '/membership/:id/checkout', to: 'pages#membership_checkout'


  resources :orders do
    get 'new_payment', to: 'payments#new', as: 'new_payment'
  end


  mount StripeEvent::Engine, at: '/stripe-webhooks'

  #back arrow
  get 'go_back', to: 'pages#go_back'


  # Custom sign-out route
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"

  end

# config/routes.rb
  namespace :pages do
  get 'memberships', to: 'memberships#index'
  end


  # Additional routes for other actions if needed

end
