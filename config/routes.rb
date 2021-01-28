Rails.application.routes.draw do
  resources :actors

  resources :movies do
    resources :reviews do
      resources :comments
    end
  end

  resources :reviews do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  devise_for :users
  root 'movies#index'
  get 'about', to: 'pages#about'
  get 'history', to: 'comments#history'
  get 'search', to: 'movies#search'
  put 'favorite', to: 'movies#favorite'
  put 'role', to: 'movies#role'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
