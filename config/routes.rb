Rails.application.routes.draw do
  root 'users#index'

  resources :posts do
    post 'like', on: :member
    resources :comments
  end

  resources :users, except: [:new] do
    resources :posts
  end

  get 'users/new', to: 'users#new', as: 'new_user'
end
