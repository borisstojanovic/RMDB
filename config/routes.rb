Rails.application.routes.draw do
  resources :movies

  devise_for :users
  root 'movies#index'
  get 'about', to: 'pages#about'
  get 'search', to: 'movies#search'
  put 'favorite', to: 'movies#favorite'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
