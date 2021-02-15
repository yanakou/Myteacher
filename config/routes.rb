Rails.application.routes.draw do
  get 'sessions/new'
  root 'application#hello' 
  get '/signup', to:'users#new'
  resources :users 
end
