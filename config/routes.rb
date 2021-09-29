Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'sessions/new'

  root to: "rooms#home"
  get "rooms/home"
  get "rooms/:id/post", to: "rooms#post", as: :rooms_post
  namespace :admin do
    resources :users
    get "users/:id/profile", to: "users#profile", as: :users_profile
  end
  resources :rooms do
    collection do
      get "search"
    end
  end
  resources :reservations

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
