Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resources :articles, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get "search"
    end
  end
  resources :users, only: [:show]
end
