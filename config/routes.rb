Rails.application.routes.draw do
  devise_for :users
  root to: 'tags#index'

  resources :tags do
    member do
      get :soft_delete
      get :trigger_tag
    end
  end

  post 'receive_webhook', to: 'webhooks#receive'
end
