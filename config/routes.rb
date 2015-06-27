Lazylegume::Application.routes.draw do
  resources :shows, only: [:index, :show, :new, :create, :destroy] do
    collection do
      post 'tvdb_search'
    end
  end
  resources :feeds
  resources :rules, only: [:new, :create, :update, :destroy]
  resources :index, only: [:index]

  resources :settings, only: [:index, :update]

  root to: 'index#index'
end
