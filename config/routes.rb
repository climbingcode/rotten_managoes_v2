Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'movies#index'

  resources :users, only: ['new', 'edit', 'create', 'destroy']
  resource :session, only: ['new', 'create', 'destroy']

  resources :movies do 
    resources :ratings, only: ['create']
    resources :comments, only: ['create']
  end

  namespace :admin do 
  	resources :users
  end

  match '/browse_as', to: 'admin/users#browse_as', via: :get
  match '/login', to: 'sessions#new', via: :get
  match '/signup', to: 'users#new', via: :get

end
