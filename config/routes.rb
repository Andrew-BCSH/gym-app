Rails.application.routes.draw do
  namespace :users do
    resource :qr_code, only: [:show]
    get '/generate_qr_code', to: 'generate_qr_code#generate_qr_code', as: 'generate_qr_code'
  end

  # For user login
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # For admin login
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  root to: 'landing_page#index'

  resources :memberships, only: [:show, :index, :new, :create, :edit, :update, :destroy]
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
  get "/products/:id", to: "pages#show_product"
  post "/products/:id", to: "pages#purchase_product", as: "purchase_product"
  get '/membership/:id/checkout', to: 'pages#membership_checkout', as: 'membership_checkout'
  get '/top_up', to: 'top_ups#index', as: 'top_ups'
  get '/top_up/:id/success', to: 'top_ups#show_success', as: 'top_up_success'
  get '/top_up/:id/failure', to: 'top_ups#show_failure', as: 'top_up_failure'
  get '/top_up/checkout/:amount', to: 'top_ups#checkout', as: 'top_up_checkout'
  get '/qr_code_info', to: 'qr_code_info#show', as: 'qr_code_info'

  resources :orders do
    get 'new_payment', to: 'payments#new', as: 'new_payment'
  end

  get 'go_back', to: 'pages#home'

  devise_scope :user do
    delete 'users/sign_out', to: 'users/sessions#destroy', as: :user_sign_out
  end

  devise_scope :admin do
    delete 'admins/sign_out', to: 'admins/sessions#destroy', as: :admin_sign_out
  end

  namespace :pages do
    get 'memberships', to: 'memberships#index'
  end

  namespace :admins do
    resources :users, only: [:destroy] # Restrict user deletion to admins
    resources :memberships do
      post 'add_days', on: :member
      post 'add_or_remove_membership_types', on: :collection
      post 'create_or_remove_membership', on: :collection
    end

    resources :weekly_class_schedule, only: [:index, :new, :create, :edit, :update, :destroy] do
      get 'new_weekly_class_schedule', to: 'weekly_class_schedule#new', as: 'new_weekly_class_schedule'
    end

    resources :membership_types, only: [:new, :create]
    post 'create_or_remove_membership', to: 'memberships#create_or_remove_membership', as: 'create_or_remove_membership'
    get 'dashboard/index', as: 'dashboard_index'
    get '/qr_code_information', to: 'member_qr_code_information#show', as: 'qr_code_information'
    resources :products, path: 'products'
    get 'mejiro_coin/admin', to: 'mejiro_coin#index', as: 'mejiro_coin_records'
    post 'mejiro_coin/add_credit', to: 'mejiro_coin#add_credit', as: 'add_credit_to_user'
    get 'memberships/show', as: 'show_membership'
  end
end
