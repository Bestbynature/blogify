Rails.application.routes.draw do
  root 'users#index'
  
  resources :posts
  resources :comments
  
  resources :users do
    resources :posts do
      post 'like', on: :member
      resources :comments 
    end
  end
  
end