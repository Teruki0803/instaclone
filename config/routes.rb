Rails.application.routes.draw do
  
  devise_for :users
  root to: "home#index"
  resources :users
  resources :photos do
    resource :favorites, only:[:create, :destroy]
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
   resources :relationships, only: [:create, :destroy]

end
