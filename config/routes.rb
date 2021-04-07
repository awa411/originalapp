Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  get "articles/search"
  resources :articles
  resources :users, only: :show
end
