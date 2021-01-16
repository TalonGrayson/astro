Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'tags#index'

  resources :tags do
    member do
      get :soft_delete
      get :trigger_tag
    end
  end

  resources :users, only: [:show]

  resources :devices, only: [:destroy]

  post 'receive_webhook', to: 'webhooks#receive'
end
