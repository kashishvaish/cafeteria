Rails.application.routes.draw do
  get "/" => "home#index", as: :home
  get "menu", to: "menu#index"
  get "myorders", to: "order_history#index"
  resources :menu_categories
  patch "/change_status", to: "menu_categories#change_status", as: :edit_category_status
  resources :menu_items
  resources :cart_items
  resources :order_items
  resources :users
  get "/view_users" => "users#show_all"
  resources :orders
  get "/all_orders/:filter" => "orders#show_all"
  post "addtocart/:id" => "menu#addtocart"
  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_sessions
  get "/menu_admin" => "admin#menu_admin"
end
