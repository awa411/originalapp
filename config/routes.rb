Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  get "articles/search"
  resources :articles do
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: [:create, :destroy]
  resources :users, only: :show
end
