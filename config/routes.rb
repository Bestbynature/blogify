Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :likes, only: [:create, :destroy] # Nested under posts only
      resources :comments 
    end
  end
end