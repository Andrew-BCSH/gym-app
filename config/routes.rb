Rails.application.routes.draw do
  # For user login
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # For admin login
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  root to: 'landing_page#index'

  resources :memberships, only: [:show, :index]
  resources :orders, only: [:show, :create]
  resources :payments, only: :new


  get '/home', to: 'pages#home'
  get '/memberships', to: 'pages#memberships'
  get '/book_a_private_class', to: 'pages#book_a_private_class'
  get '/mejiro_coin', to: 'pages#mejiro_coin'
  get '/payment_scanner', to: 'pages#payment_scanner'
  get '/weekly_class_schedule', to: 'pages#weekly_class_schedule'
  get '/events', to: 'pages#events'
  get '/qr_code_scanner', to: 'pages#qr_code_scanner'
  get '/membership_details', to: 'pages#membership_details', as: 'membership_details'

  # Define the membership checkout route
  get '/membership/:id/checkout', to: 'pages#membership_checkout', as: 'membership_checkout'

  # Define the top-up route for the top-ups controller
  get '/top_up', to: 'top_ups#index', as: 'top_ups'
  get '/top_up/:id/success', to: 'top_ups#show_success', as:'top_up_success'
  get '/top_up/:id/failure', to: 'top_ups#show_failure', as:'top_up_failure'
  # Add a route for top-up checkout
  get '/top_up/checkout/:amount', to: 'top_ups#checkout', as: 'top_up_checkout'

  resources :orders do
    get 'new_payment', to: 'payments#new', as: 'new_payment'
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get 'go_back', to: 'pages#home'

  # Define custom user sign-out route
  devise_scope :user do
    delete 'users/sign_out', to: 'users/sessions#destroy', as: :user_sign_out
  end

  # Define custom admin sign-out route
  devise_scope :admin do
    delete 'admins/sign_out', to: 'admins/sessions#destroy', as: :admin_sign_out
  end

  namespace :pages do
    get 'memberships', to: 'memberships#index'
  end

  namespace :admins do
    get 'dashboard/index'
  end
end
