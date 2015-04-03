Lazylegume::Application.routes.draw do
  resources :shows
  resources :feeds
  resources :rules, only: [:new, :create, :update, :destroy]
  resources :index, only: [:index]

  root to: 'index#index'
end
