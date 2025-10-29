Rails.application.routes.draw do
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  get 'admin', to: 'admin#index'
  get 'sessions/destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :theatres
  resources :movies
  resources :shows, only: [:new, :create, :index, :show]
  resources :bookings, only: [:new, :create, :index]


end
