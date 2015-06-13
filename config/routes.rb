Lazylegume::Application.routes.draw do
  resources :shows do
    collection do
      post 'tvdb_search'
    end
  end
  resources :feeds
  resources :rules, only: [:new, :create, :update, :destroy]
  resources :index, only: [:index]

  root to: 'index#index'
end
