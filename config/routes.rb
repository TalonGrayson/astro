Rails.application.routes.draw do
  root to: 'tags#index'

  resources :tags do
    member do
      get :soft_delete
      get :trigger_tag
    end
  end

  post 'receive_webhook', to: 'webhooks#receive'
end
