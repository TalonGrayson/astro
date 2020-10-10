Rails.application.routes.draw do
  resources :tags do
    member do
      get :soft_delete
    end
  end
end
