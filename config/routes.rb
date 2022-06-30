Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do 
    resources :reviews
    resources :favorites, only: [:create, :destroy] 
  end

  resources :users 
  get 'signup', to: 'users#new', as: 'signup'

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
end
