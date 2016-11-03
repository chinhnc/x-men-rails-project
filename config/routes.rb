Rails.application.routes.draw do
  mount LikeDislike::Engine, at: "/"
  root "animes#index"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  devise_for :users, path: "", path_names: {
    sign_in: "login", sign_out: "logout",
    password: "secret", confirmation: "verification",
    unlock: "unblock", registration: "register", sign_up: "" }

  resources :users, only: :show
  resources :animes, only: [:index, :show]
  resources :reviews
  resources :votes, only: [:create, :destroy]
  resources :comments

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :categories
    resources :animes do
      collection do
        match "search" => "admin#animes#index",
          via: [:get, :post], as: :search
      end
    end
    resources :reviews, only: [:index, :show, :destroy]
    resources :comments, only: [:destroy]
  end
end
