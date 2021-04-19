Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'sessions/new'
  root 'tweets#index' 
  get '/signup', to:'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
        get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :tweets do 
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]
end
