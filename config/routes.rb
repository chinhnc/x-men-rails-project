Rails.application.routes.draw do
  mount LikeDislike::Engine, at: "/"
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  devise_for :users, path: "", path_names: {
    sign_in: "login", sign_out: "logout",
    password: "secret", confirmation: "verification",
    unlock: "unblock", registration: "register", sign_up: "" }

  resources :users, only: [:show]
  resources :animes, only: [:index, :show]
  resources :reviews
  resources :votes, only: [:create, :destroy]
  resources :comments
end
