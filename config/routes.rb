Rails.application.routes.draw do
  get "/" => "home#index"
  get "menu", to: "menu#index"
  resources :cart_items
  resources :order_items
  resources :users
  resources :orders
  post "addtocart/:id" => "menu#addtocart"
  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_sessions
end
