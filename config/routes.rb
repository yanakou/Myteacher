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
        get :likes, :following, :followers
    end
    get 'timeline', on: :collection
  end

  resources :relationships, only: [:create, :destroy]
  
  namespace :tweets do
    resources :searches, only: :index # 検索機能
  end
  
  resources :tweets do
    collection do
      get :likes, :tags # 人気投稿とタグ一覧
    end 
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :notifications, only: :index
end
