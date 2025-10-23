Rails.application.routes.draw do
  get 'shows/index'
  get 'shows/create'
  get 'shows/new'
  get 'shows/show'
  get 'admin/index'
  get 'movies/index'
  get 'movies/new'
  get 'movies/create'
  get 'movies/show'
  get 'movies/destroy'
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get 'admin', to: 'admin#index'

  get 'sessions/destroy'
  get 'theatre/index'
  get 'theatre/show'
  get 'theatre/create'
  get 'theatre/destroy'
  get 'theatre/update'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :theatres
  resources :movies
  resources :shows, only: [:new, :create, :index, :show]
  resources :bookings, only: [:new, :create, :index]


end
